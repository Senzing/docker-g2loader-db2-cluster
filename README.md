# docker-g2loader-db2-cluster

## Overview

This Dockerfile is a wrapper over Senzing's G2Loader.py using the DB2 database cluster.

### Contents

1. [Build docker image](#build-docker-image)
1. [Create SENZING_DIR](#create-senzing_dir)
1. [Set environment variables](#set-environment-variables)
1. [Run Docker container](#run-docker-container)

## Build docker image

1. If `senzing/python-db2-cluster-base` image is not in local docker repository, it must be built manually.
   Follow the build instructions at
   [github.com/Senzing/docker-python-db2-cluster-base](https://github.com/Senzing/docker-python-db2-cluster-base#build)

1. Build image:

    ```console
    docker build --tag senzing/g2loader-db2-cluster https://github.com/senzing/docker-g2loader-db2-cluster.git
    ```

## Create SENZING_DIR

1. If you do not already have an `/opt/senzing` directory on your local system, visit
   [HOWTO - Create SENZING_DIR](https://github.com/Senzing/knowledge-base/blob/master/HOWTO/create-senzing-dir.md).

## Set environment variables

1. Identify the Senzing directory.
   Example:

    ```console
    export SENZING_DIR=/opt/senzing
    ```

1. Identify the host and port running DB2 server.
   Example:

    ```console
    docker ps

    # Choose value from NAMES column of docker ps
    export DB2_HOST_CORE=docker-container-name-1
    export DB2_HOST_RES=docker-container-name-2
    export DB2_HOST_LIBFE=docker-container-name-3
    ```

    ```console
    export DB2_PORT_CORE=50000
    export DB2_PORT_RES=50000
    export DB2_PORT_LIBFE=50000
    ```

1. Identify the database username and password.
   Example:

    ```console
    export DB2_USERNAME_CORE=db2inst1
    export DB2_USERNAME_RES=db2inst1
    export DB2_USERNAME_LIBFE=db2inst1

    export DB2_PASSWORD_CORE=db2inst1
    export DB2_PASSWORD_RES=db2inst1
    export DB2_PASSWORD_LIBFE=db2inst1
    ```

1. Identify the database that is the target of the SQL statements.
   Example:

    ```console
    export DB2_DATABASE_ALIAS_CORE=G2_CORE
    export DB2_DATABASE_ALIAS_RES=G2_RES
    export DB2_DATABASE_ALIAS_LIBFE=G2_LIBFE
    ```

1. Identify the Docker network of the DB2 database.
   Example:

    ```console
    docker network ls

    # Choose value from NAME column of docker network ls
    export DB2_NETWORK=nameofthe_network
    ```

## Run docker container

1. Run the docker container.

    ```console
    docker run -it  \
      --volume ${SENZING_DIR}:/opt/senzing \
      --net ${DB2_NETWORK} \
      --env SENZING_CORE_DATABASE_URL="db2://${DB2_USERNAME_CORE}:${DB2_PASSWORD_CORE}@${DB2_HOST_CORE}:${DB2_PORT_CORE}/${DB2_DATABASE_ALIAS_CORE}" \
      --env SENZING_RES_DATABASE_URL="db2://${DB2_USERNAME_RES}:${DB2_PASSWORD_RES}@${DB2_HOST_RES}:${DB2_PORT_RES}/${DB2_DATABASE_ALIAS_RES}" \
      --env SENZING_LIBFE_DATABASE_URL="db2://${DB2_USERNAME_LIBFE}:${DB2_PASSWORD_LIBFE}@${DB2_HOST_LIBFE}:${DB2_PORT_LIBFE}/${DB2_DATABASE_ALIAS_LIBFE}" \
      senzing/g2loader-db2-cluster \
        --purgeFirst \
        --projectFile /opt/senzing/g2/python/demo/sample/project.csv
    ```
