#!/bin/bash
set -e

echo "Making migrations..."
python webapp/manage.py makemigrations

echo "Running migrations..."
python webapp/manage.py migrate

echo "Checking if superuser exists..."
python webapp/manage.py shell -c "
from django.contrib.auth import get_user_model
import os
User = get_user_model()
if not User.objects.filter(username=os.environ['ADMIN_USERNAME'], is_superuser=True).exists():
    print('No superuser found. Creating one...')
    User.objects.create_superuser(
        username=os.environ['ADMIN_USERNAME'],
        email=os.environ['ADMIN_EMAIL'],
        password=os.environ['ADMIN_PASSWORD']
    )
else:
    print('Superuser already exists. Skipping creation.')
"

echo "Starting app..."
exec "$@"
