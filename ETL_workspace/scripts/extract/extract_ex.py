# from utils.path_helper import add_project_root
# add_project_root()

# import pandas as pd
# import gspread
# import yaml
# from config.col_mapping import DEDUCTION_RATE_RENAME_MAP
# from config.value_mapping import CHNNEL_NAME_RENAME_MAP
# from utils.gsheet_sources_loader import gsheet_resources

# # Extract deduction rate table from Google Sheet and apply column/value mappings

# def read_gsheet_deduction_rate():
#     url = gsheet_resources["gsheet_deduction_rate"]["url"] 
#     sheet_name = gsheet_resources["gsheet_deduction_rate"]["sheet_name"]
#     connection = gspread.service_account('d:\\Desktop\\DS_workspace\\sp01_app_op_data_analysis\\BQ_401707_sp01_token_0109.json')
#     sheet = connection.open_by_url(url).worksheet(sheet_name)
#     df = pd.DataFrame(sheet.get_all_records())
#     df.rename(columns={k: v for k, v in DEDUCTION_RATE_RENAME_MAP.items() if k in df.columns}, inplace=True)
#     df['channel_id'] = df['channel_id'].replace(CHNNEL_NAME_RENAME_MAP)
#     df['channel_id'] = df['channel_id'].str.replace("渠道", "", regex=False)
#     return df.iloc[:, 0:2]