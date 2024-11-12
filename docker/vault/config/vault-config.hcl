storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 0 # 啟用 TLS 加密
  tls_cert_file = "/vault/tls/vault.crt"
  tls_key_file  = "/vault/tls/vault.key"
}

#  Web interface
ui = true 

api_addr = "https://127.0.0.1:8200"
# cluster_addr = "https://127.0.0.1:8201" 

# 啟用審計日誌
audit {
  type = "file"
  path = "/vault/logs/audit.log"
}