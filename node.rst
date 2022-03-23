Node tips
=========

Automatically initialize node environment with .nvm if something is found

.. code-block:: shell

    # File ~/.zshrc
    test -f ./.nvmrc && nvm use

Use Node 14.x (aka Gallium) in a project.

.. code-block:: shell

    echo lts/fermium > .nvmrc

Use Node 16.x (aka Gallium) in a project.

.. code-block:: shell

   echo lts/gallium > .nvmrc


See `Node codenames <https://github.com/nodejs/Release/blob/main/CODENAMES.md>`_

Pinning verisons
----------------

You can pin Node and NPM to a specific version.

Add to package.json

.. code-block:: javascript

    "engines": {
        "node": "^16",
        "npm": "^8"
    },

Create an `.npmrc` file.

.. code-block:: bash

    echo "engine-strict=true" > .npmrc


See

- `package.json engines <https://docs.npmjs.com/cli/v8/configuring-npm/package-json#engines>`_
- `config engine-strict <https://docs.npmjs.com/cli/v8/using-npm/config#engine-strict>`_
- `npmrc format and location <https://docs.npmjs.com/cli/v8/configuring-npm/npmrc>`_


Linters
-------

Install eslint and prettier

.. code-block:: shell

    yarn add -D eslint prettier eslint-config-google eslint-config-prettier

Add configuration file `.eslintrc.js`

.. code-block:: javascript

    module.exports = {
    extends: ["google", "eslint:recommended", "prettier"],
        parserOptions: {
            ecmaVersion: 2017,
        },
        env: {
            es6: true,
            node: true,
        },
        rules: {
            'require-jsdoc': 'off',
        },
    };

Add a configuration file for prettier: `.prettierrc.json`:

.. code-block:: json

    {
        "singleQuote": true
    }

Install lint-staged and husky:

.. code-block:: shell

    npx mrm@2 lint-staged

It installs dependencies and creates necessary config files.
