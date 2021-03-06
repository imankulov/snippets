Pre-commit hooks
================


Pre-commit config
-----------------

File ``.pre-commit-config.yaml``. Use ``pre-commit install`` to activate it.

.. code-block:: yaml

    default_language_version:
      python: python3.9

    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.0.1
        hooks:
          - id: trailing-whitespace
          - id: check-merge-conflict
          - id: check-case-conflict
          - id: debug-statements

      - repo: https://github.com/pycqa/pydocstyle
        rev: 6.1.1
        hooks:
          - id: pydocstyle

      - repo: https://github.com/terrencepreilly/darglint
        rev: v1.8.1
        hooks:
        - id: darglint

      - repo: https://github.com/myint/autoflake
        rev: v1.4
        hooks:
          - id: autoflake
            args:
              - --in-place
              - --remove-unused-variables
              - --remove-all-unused-imports
              - --expand-star-imports

      - repo: https://github.com/psf/black
        rev: 21.12b0
        hooks:
          - id: black

      - repo: https://github.com/pre-commit/mirrors-mypy
        rev: v0.920
        hooks:
          - id: mypy

      - repo: https://github.com/PyCQA/isort
        rev: 5.10.1
        hooks:
          - id: isort

      - repo: https://gitlab.com/pycqa/flake8
        rev: 3.9.2
        hooks:
          - id: flake8

      - repo: https://github.com/seddonym/import-linter
        rev: v1.2.6
        hooks:
          - id: import-linter
