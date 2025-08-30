dev:
	uv run webapp/manage.py runserver

migrate:
	uv run webapp/manage.py makemigrations
	uv run webapp/manage.py migrate

collectstatic:
	uv run webapp/manage.py collectstatic
	rm -rf webapp/staticfiles/django-browser-reload

# Before this run: docker network create web - one-time thing useful for using same proxy for multiple docker apps
# OR you can add caddy proxy inside docker-compose.yml if you are runnig just this app

startproxy:
	docker compose -p proxy -f docker-compose.proxy.yml up -d --force-recreate

startapp:
	docker compose -p app -f docker-compose.yml up -d --force-recreate

start: 
	make startproxy 
	make startapp

stopproxy:
	docker compose -p proxy -f docker-compose.proxy.yml down

stopapp:
	docker compose -p app -f docker-compose.yml down

stop:
	make stopapp
	make stopproxy

build:
	docker compose -p app -f docker-compose.yml build

applogs:
	docker compose -p app -f docker-compose.yml logs app -ft

proxylogs:
	docker compose -p proxy -f docker-compose.proxy.yml logs external-caddy-proxy -ft

appexec:
	docker compose -p app -f docker-compose.yml exec app bash