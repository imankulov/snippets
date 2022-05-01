Python project
==============

Common files for a Python project.

Dependencies
------------

.. code-block:: shell

    poetry add python-dotenv ipython deescovery

Top-level files
---------------

File :file:`myproject/config.py`

.. code-block:: python

    """Configuration.

    The module doesn't depend on the project. The configuration file is initialized
    with python-dotenv, and we don't read environment variables in the rest of the
    project.


    What config.py can import?
    --------------------------

    The module doesn't import anything from the project.


    Who can import config.py?
    ---------------------------

    The module is imported by the app.py to create services. It can also be imported in
    the other parts of the application: for example, to get access to PROJECT_ROOT, or to
    create project-specific services from requisites, provided in the config.
    """
    import os
    import pathlib

    import dotenv

    PROJECT_ROOT = pathlib.Path(__file__).parents[1]

    dotenv.load_dotenv((PROJECT_ROOT / ".env").as_posix())

    # --------------------------------------------------------------------------------
    # Server configuration
    # --------------------------------------------------------------------------------
    HOST = os.environ.get("HOST", "0.0.0.0")
    PORT = int(os.environ.get("PORT", 5000))


File :file:`myproject/services.py`

.. code-block:: python

    """Services.

    The module provides a "registry" or "service locator" for other modules of the
    application. It may initialize stub objects for extensions, that are configured
    inside the app.py later on.

    What services.py can import?
    ----------------------------

    The module doesn't import anything from the project.


    Who can import services.py?
    --------------------------

    The module is imported by different modules across the project, as necessary.
    """
    # FastAPI example
    from fastapi import FastAPI

    fastapi_app = FastAPI()



File :file:`myproject/app.py`

.. code-block:: python

    """Application.

    The module is used to initialize the main project: load configuration and
    initialize services.

    What app.py can import?
    -----------------------

    Services, configuration, and everything that is needed to initialize application,
    including controllers and models inside apps. In other words, app.py depends on
    a lot of things in the project.


    Who can import app.py?
    ----------------------

    The module is not imported from anywhere except from a WSGI/ASGI server in
    production, and conftests.py for pytest.
    """
    from importlib import import_module

    from deescovery import ModuleRule, discover
    from deescovery.matchers import MatchByPattern

    from myproject import config

    api_loader = ModuleRule(
        name="FastAPI API endpoints loader",
        module_matches=MatchByPattern(patterns=["myproject.*.api"]),
        module_action=import_module,
    )


    def init(**kwargs):
        update_config(kwargs)
        discover("myproject", rules=[api_loader])


    def update_config(kwargs):
        """Override values of the myproject.config.

        Helpful for tests, when we need to dynamically override some settings.
        """
        for k, v in kwargs.items():
            setattr(config, k, v)


File :file:`manage.py`

.. code-block:: python

    #!/usr/bin/env python
    """Management script."""
    import datetime
    from typing import Iterable, List

    import click
    from IPython import embed

    from myproject import app


    @click.group()
    def cli():
        app.init()

    @cli.command()
    def shell():
        """Open IPython console."""
        embed(colors="neutral")

    if __name__ == "__main__":
        cli()
