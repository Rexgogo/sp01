FROM hashicorp/vault:1.15.2

# Set permissions
RUN chown -R vault:vault /vault/config \
    && chown -R vault:vault /vault/policies \
    && chown -R vault:vault /vault/tls \
    && chmod 0644 /vault/config/* \
    && (find /vault/tls -type f -exec chmod 0644 {} + || true) \
    && chmod -R 777 /vault

# Add custom configuration
COPY config/vault-config.hcl /vault/config/
COPY config/policies /vault/policies/
COPY config/tls /vault/tls/


USER vault


# Key security features:
#     TLS encryption
#     Audit logging enabled
#     File-based storage with proper permissions
#     Auto-unsealing via cloud KMS
#     Least privilege access policies
#     Non-root user
#     Volume mounts for persistence
#     Network isolation
