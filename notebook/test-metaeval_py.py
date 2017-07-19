import requests


url = 'http://metadig.nceas.ucsb.edu/metadata/evaluator'
files = {'zipxml': open('../upload/metadata.zip', 'rb')}
r = requests.post(url, files=files)
r.raise_for_status()
