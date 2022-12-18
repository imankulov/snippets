Docker and docker-compose
#########################

Helpful services
================

- `composerize: convert docker run to docker-compose <https://www.composerize.com/>`_

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
    # DATABASE_URL=psql://myproject:password@127.0.0.1:5499/myproject
    version: "3.3"

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
    version: "3.3"

    services:
      redis:
        image: redis:alpine
        ports:
          - "127.0.0.1:6399:6379"
        volumes:
          - redis-data:/data

    volumes:
      redis-data: {}


Keycloak
--------

Keycloak with the standalone database.


.. code-block:: yaml

    version: "3.3"

    services:
      keycloak:
        image: quay.io/keycloak/keycloak:latest
        ports:
          - "127.0.0.1:8080:8080"
        volumes:
          - keycloak-data:/opt/jboss/keycloak/standalone/data/
        environment:
          KEYCLOAK_USER: admin
          KEYCLOAK_PASSWORD: password

    volumes:
      keycloak-data: {}


See `Get started with Keycloak on Docker <https://www.keycloak.org/getting-started/getting-started-docker>`_.

Fake email with Inbucket
------------------------

With `Inbucket <https://www.inbucket.org/>`_.

.. code-block:: yaml

    version: "3.3"
    services:

      # SMTP server is available at localhost:2500 or inbucket:2500.
      # The web UI is available at http://localhost:9000.
      # POP3 interface is at localhost:1100
      inbucket:
        image: inbucket/inbucket
        ports:
          - "9000:9000"
          - "2500:2500"
          - "1100:1100"



Configuration with `django-environ <https://django-environ.readthedocs.io/en/latest/tips.html#email-settings>`__.


.. code-block:: python

    EMAIL_CONFIG = env.email("EMAIL_URL", default="smtp://localhost:2500")
    vars().update(EMAIL_CONFIG)


Fake email with MailHog
-----------------------

With `MailHog <https://github.com/mailhog/MailHog>`_.


.. code-block:: yaml

    version: "3.3"
    services:

      # SMTP server is available at localhost:1025 or mailhog:1025.
      # The web UI is available at http://localhost:8025.
      mailhog:
        image: mailhog/mailhog
        ports:
          - "1025:1025"
          - "8025:8025"


Configuration with `django-environ <https://django-environ.readthedocs.io/en/latest/tips.html#email-settings>`__.


.. code-block:: python

    EMAIL_CONFIG = env.email("EMAIL_URL", default="smtp://localhost:1025")
    vars().update(EMAIL_CONFIG)


Sending an email from Django to see if it works:

.. code-block:: python

    from django.core.mail import send_mail
    send_mail("subject", "message", "noreply@example.com", ["admin@example.com"])
