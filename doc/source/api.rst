APIs
====

Bridge
------
External functions
^^^^^^^^^^^^^^^^^^

bridge-ng-to-ng
~~~~~~~~~~~~~~~
*src-ledger* ``module{ng-poly-fungible-v1}`` *dst-ledger* ``module{ng-poly-fungible-v1}`` *token-id* ``string`` *account* ``string`` *amount* ``decimal`` *→* ``bool``

Bridge a token (or share of a poly-fungible) from a Marmalade NG ledger to another Marmalade NG ledger.

Both ledgers must use the same *token-id*.

Example:

.. code-block:: lisp

  (bridge-ng-to-ng marmalade-ng.legder another-ns.ledger
                   "t:6TI5-4FQSmYakGsxlouN9h9RcGk4vxUQCxKi6rNJ1DY"
                   "k:35c6e214b516e03e3d609558e81636dc61f96782f52b1f72222528dbbf6170b4" 1.0)


bridge-v1-to-ng
~~~~~~~~~~~~~~~
*src-ledger* ``module{kip.poly-fungible-v2}`` *src-helper* ``module{marmalade-burn-helper-v1}`` *dst-ledger* ``module{ng-poly-fungible-v1}`` *src-token-id* ``string`` *dst-token-id* ``string`` *account* ``string`` *amount* ``decimal`` *→* ``bool``

Bridge a token (or share of a poly-fungible) from a Marmalade V1 ledger to another Marmalade NG ledger.

An helper is required (see V1 Adapters)

Example:

.. code-block:: lisp

  (bridge-v1-to-ng marmalade.legder marmalade-ng-bridge.marmalade-std-helper
                   marmalade-ng.ledger
                   "t:422uU9AJHLeLr6iPGHCkUA_eIvTboKKp5dXaUmctCAw"
                   "t:6TI5-4FQSmYakGsxlouN9h9RcGk4vxUQCxKi6rNJ1DY"
                   "k:35c6e214b516e03e3d609558e81636dc61f96782f52b1f72222528dbbf6170b4" 1.0)

bridge-ng-loop
~~~~~~~~~~~~~~
*ledger* ``module{ng-poly-fungible-v1}`` *src-token-id* ``string`` *dst-token-id* ``string`` *account* ``string`` *amount* ``decimal`` *→* ``bool``

Upgrade a *src-token* to a new *dst-token* on the same ledger.

Example:

.. code-block:: lisp

  (bridge-ng-loop marmalade-ng.ledger
                  "t:422uU9AJHLeLr6iPGHCkUA_eIvTboKKp5dXaUmctCAw"
                  "t:6TI5-4FQSmYakGsxlouN9h9RcGk4vxUQCxKi6rNJ1DY"
                  "k:35c6e214b516e03e3d609558e81636dc61f96782f52b1f72222528dbbf6170b4" 1.0)

bridge-generic-to-ng
~~~~~~~~~~~~~~~~~~~~
*src-ledger* ``module{generic-burnable-nft-v1}`` *dst-ledger* ``module{ng-poly-fungible-v1}`` *src-token-id* ``string`` *dst-token-id* ``string`` *→* ``bool``

Bridge a token from a generic ledger (must implement generic-burnable-nft) to a Marmalade NG ledger

.. code-block:: lisp

  (bridge-generic-to-ng free.eighties-bulls marmalade-ng.ledger
                        "t:422uU9AJHLeLr6iPGHCkUA_eIvTboKKp5dXaUmctCAw"
                        "t:6TI5-4FQSmYakGsxlouN9h9RcGk4vxUQCxKi6rNJ1DY"
                        1.0)

bridge-ng-xchain (defpact)
~~~~~~~~~~~~~~~~~~~~~~~~~~
*ledger* ``module{ng-poly-fungible-v1}`` *dst-chain* ``string`` *token-id* ``string`` *account* ``string`` *amount* ``decimal``

Bridge a token X-chain.
Both ledgers must have the same fully qualified name. Both ledgers must use the same *token-id*.

.. code-block:: lisp

    (bridge-ng-xchain marmalade-ng.ledger "8"
                      "t:422uU9AJHLeLr6iPGHCkUA_eIvTboKKp5dXaUmctCAw"
                      "k:35c6e214b516e03e3d609558e81636dc61f96782f52b1f72222528dbbf6170b4" 1.0)


Requirable Capabilities
^^^^^^^^^^^^^^^^^^^^^^^
These capability must be *called* from policies or ledger using ``require-capability``.

ALLOW-BURN
~~~~~~~~~~
*ledger* ``module{ng-poly-fungible-v1}`` *token-id* ``string`` *dest* ``object{bridge-target}``

Must be used by a Marmalade NG policy only, for burning tokens

ALLOW-BURN-V1
~~~~~~~~~~~~~
*ledger* ``module{kip.poly-fungible-v2}`` *token-id* ``string`` *dest* ``object{bridge-target}``

Must be used by a Marmalade V1 policy only, for burning tokens

ALLOW-BURN-GENERIC
~~~~~~~~~~~~~~~~~~
*ledger* ``module{generic-burnable-nft-v1}`` *token-id* ``string`` *dest* ``object{bridge-target}``

Must be used by a Generic ledger (implements generic-burnable-nft-v1), for burning tokens


ALLOW-MINT
~~~~~~~~~~
*ledger* ``module{ng-poly-fungible-v1}`` *token-id* ``string`` *source* ``object{bridge-target}``

Must be used by a Marmalade NG policy only, for minting tokens.


Marmalade NG policies
---------------------

TODO
