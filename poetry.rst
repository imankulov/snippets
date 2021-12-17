Poetry
======

Initialization
--------------

Quickly initialize a new Python environment with Poetry. We explicitly stick to Python 3.10.x (we don't want automatic upgrades to 3.11). Also, we activate Poetry virtual environment on startup.

.. code-block:: shell

    poetry init --python '~3.10' --no-interaction --quiet
    poetry install
    echo 'source $(poetry env info -p)/bin/activate' > .startup
