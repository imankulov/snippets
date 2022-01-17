Docker and docker-compose
#########################

Docker commands
===============


Reclaim disk space
------------------

Clean up disk space by removing all the docker containers older than 14 days.


.. code-block:: bash

   docker image prune -a --filter "until=336h"


See `Prune unused Docker objects <https://docs.docker.com/config/pruning/>`_


Run a container and attach current directory
---------------------------------------------

Example for a specific version of Python.

.. code-block:: bash

   docker run -v $(pwd):/app  --rm -it python:3.10  bash


Docker-compose Snippets
=======================




PostgreSQL
----------

Sample docker-compose file to run a PostgreSQL server.

.. code-block:: yaml

    # The storage can be cleaned up by running the command:
    # docker-compose down -v
    #
    # Django-environ settings:
    # DATABASE_URL=psql://myproject:password@127.0.0.1:5483/myproject
    version: "3.2"

    services:
      db:
        image: postgres:14
        environment:
          POSTGRES_USER: myproject
          POSTGRES_PASSWORD: password
          POSTGRES_DB: myproject
        ports:
          - "127.0.0.1:5499:5432"
        volumes:
          - "postgres-data:/var/lib/postgresql/data"

    volumes:
      postgres-data: {}


Redis
-----

Sample docker-compose file to run a Redis server.


.. code-block:: yaml

    # Sample docker-compose file to run a Redis server
    # store data in a persistent storage.
    #
    # The storage can be cleaned up by running the command:
    # docker-compose down -v
    #
    # Connect to this instance from the command-line:
    # redis-cli -p 6314
    #
    # Connect to this instance from Python:
    #
    # REDIS_URL = "redis://localhost:6399"
    # redis = Redis.from_url(REDIS_URL)
    version: "3.2"

    services:
      redis:
        image: redis:alpine
        ports:
          - "127.0.0.1:6399:6379"
        volumes:
          - redis-data:/data

    volumes:
      redis-data: {}
