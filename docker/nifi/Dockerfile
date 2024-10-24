FROM apache/nifi:1.25.0

#RUN mkdir -p /opt/nifi/nifi-1.25.0/database_repository/ &&\
# 	cp ./nifi/titanic_dataset /opt/nifi/nifi-1.25.0/database_repository/

ENV SINGLE_USER_CREDENTIALS_USERNAME=${NIFI_USERNAME}
ENV SINGLE_USER_CREDENTIALS_PASSWORD=${NIFI_PASSWORD}

CMD ["/bin/sh", "/opt/nifi/init-nifi.sh"]

EXPOSE 8443 8092