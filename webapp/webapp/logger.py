import os
from webapp.settings import logpath
from loguru import logger as log


def overwrite_on_100mb(message, file):
    if os.path.exists(logpath) and os.path.getsize(logpath) >= 100 * 1024 * 1024:
        file.close()
        os.remove(logpath)  
        return logpath


log.add(
    logpath,
    enqueue=True,
    level="INFO",
    rotation=overwrite_on_100mb,
    retention=None,
    compression=None,
)
