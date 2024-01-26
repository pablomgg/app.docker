FROM mcr.microsoft.com/mssql/server:2019-latest

EXPOSE 1433

ENV ACCEPT_EULA=${ACCEPT_EULA:-Y}
ENV SA_PASSWORD=${SA_PASSWORD:-SiriemaB@nguela5}
ENV DATABASE=${DATABASE:-Example}
ENV MSSQL_DATA_DIR=${MSSQL_DATA_DIR:-/var/opt/sqlserver/data}
ENV MSSQL_LOG_DIR=${MSSQL_LOG_DIR:-/var/opt/sqlserver/log}
ENV MSSQL_BACKUP_DIR=${MSSQL_BACKUP_DIR:-/var/opt/sqlserver/backup}

COPY . .
ENTRYPOINT [ "/bin/bash", "./entrypoint.sh" ]

USER root 

# creating directories
RUN mkdir -p /var/opt/sqlserver
RUN mkdir -p /var/opt/sqlserver/data
RUN mkdir -p /var/opt/sqlserver/log
RUN mkdir -p /var/opt/sqlserver/backup

CMD [ "/opt/mssql/bin/sqlservr" ]