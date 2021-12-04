#!/bin/bash
# quickly initialize a new Python environment with Poetry
poetry init -n
poetry install
echo 'source $(poetry env info -p)/bin/activate' > .startup
