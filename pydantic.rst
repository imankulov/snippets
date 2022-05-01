Pydantic Snippets
=================

Project-specific models
-----------------------


See `Pydantic model options <https://pydantic-docs.helpmanual.io/usage/model_config/#options>`_ for more options.

.. code-block:: python

    class Model(BaseModel):
        """Generic project-specific model."""

        class Config:
            # Allow field population by its name or alias
            # (helpful for mapping external API values)
            allow_population_by_field_name = True


    class FrozenModel(BaseModel):
        """Generic project-specific frozen model."""

        class Config:
            # Make it frozen to allow using as dict keys
            frozen = True
            # Allow field population by its name or alias
            # (helpful for mapping external API values)
            allow_population_by_field_name = True



Integration with Arrow
----------------------

.. code-block:: python

    class PyArrow(arrow.Arrow):
        """FastAPI-serializable arrow instance."""

        @classmethod
        def __get_validators__(cls):
            yield cls.validate

        @classmethod
        def validate(cls, v):
            if v is None:
                raise ValueError("Invalid value")
            return arrow.get(v)

        @classmethod
        def __modify_schema__(cls, field_schema):
            field_schema.update(type="string")

