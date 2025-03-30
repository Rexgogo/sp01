from google.cloud import bigquery

# this methods needs set credentials in environment variable:
# (powershell) $env:GOOGLE_APPLICATION_CREDENTIALS="path/to/your/service-account-file.json"
# (check credentials) echo $env:GOOGLE_APPLICATION_CREDENTIALS


def get_bigquery_client():
    client = bigquery.Client()
    return client
