Concepts
========

Bridging procedures
-------------------

#. The tokens must be created on both ledgers, but not necessarily minted

#. The user calls the bridge function, on the bridge component

#. The bridge burns the token on the source ledger

#. The bridge mints the token on the destination ledger

#. Guardd are copied and must match.


Target object
-------------
The security and allowance of the system is based on the ``bridge-target`` object.
This object is defined in ``bridge-util.pact``.

.. code-block:: lisp

  (defschema bridge-target
    ledger:string
    token:string
    chain:string
  )

Each endpoint of the bridge must manage a ``bridge-target`` object. This object
is a reference to the opposite endpoint of the bridge.

If the endpoint is outbound:
  - The ``bridge-target`` represents the allowed direction of the token.

If the endpoint id inbound:
  - The ``bridge-target`` represents the source token that allows to mint the considered token.

Requirements:

TABLE TO DO



Allowances
----------
Each bridge endpoint (policies for Marmalade) must request the bridge by calling
`require-capability` to one of those capabilities:

- ``ALLOW-BURN``
- ``ALLOW-BURN-V1``
- ``ALLOW-BURN-GENERIC``
- ``ALLOW-BURN-MINT``

All those capabilities have the same argument:
  - **current-ledger** : modref
  - **token-id** : string
  - **target** : object{bridge-target}
