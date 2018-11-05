FROM senzing/python-db2-base

ENV REFRESHED_AT=2018-11-02

# Copy files from repository.

COPY ./root /

# Run-time command

WORKDIR /opt/senzing/g2/python
ENTRYPOINT ["/app/docker-entrypoint.sh"]
