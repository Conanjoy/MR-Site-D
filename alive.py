import time
import requests
import os

BASE_URL = os.environ.get('BASE_URL', None)
try:
    if len(BASE_URL) == 0:
        BASE_URL = None
except:
    BASE_URL = None

if BASE_URL is not None:
    while True:
        time.sleep(600)
        status = requests.get(BASE_URL).status_code