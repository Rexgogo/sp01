from google.cloud import bigquery
import pandas as pd


def load_csv_to_bigquery(csv_file, dataset_id, table_id):
    """
    load_csv_to_bigquery
    Variables:
        csv_file: str, csv file path
        dataset_id: str, bigquery dataset id (e.g. sp001.op) 
        table_id: str, bigquery table id (e.g int_profit_detail)
    """
    client = bigquery.Client(credentials=credentials)

    df = pd.read_csv(csv_file)

    table_name = f"{dataset_id}.{table_id}"

    job = client.load_table_from_dataframe(df, table_name)
    
    try:
        # wait for job to complete(if error, raise exception)
        job.result()
        
        # use job.state to check status(could be "DONE", "RUNNING", "PENDING")
        if job.state != "DONE":
            # collect error message
            error_message = f"Job state: {job.state}"
            
            # collect error details, if exists
            if job.error_result:
                # append error details to error message(as a list)
                error_message += f", Error: {job.error_result}"

            raise Exception(error_message)
        # print success message
        print(f"Sucessfully loaded csv file to Bigquery tabel: {table_name}")

    except Exception as e:
        print(f"Something wrong while loading csv file to Bigquery: {e}")
