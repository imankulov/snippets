AWS Tips
========

Set up personal AWS profile to use
-----------------------------------

.. code-block:: shell

   echo "export AWS_PROFILE=personal" >> .startup

Account info for your current requisites
----------------------------------------

.. code-block:: shell

   aws sts get-caller-identity
