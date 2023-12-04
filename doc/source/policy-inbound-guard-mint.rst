.. _POLICY-BRIDGE-INBOUND-GUARD-MINT:

policy-bridge-inbound-guard-mint
--------------------------------

Description
^^^^^^^^^^^

Allows a token to be bridged in, according to the target object.

On top of that, the policy allows token to be minted from "nothing" when the traansaction is signed
with the provided guard.

**Note:** Incompatible with the ``INSTANT-MINT`` policy, or a guarded mint of the ``GUARD`` policy.

Implemented hooks
^^^^^^^^^^^^^^^^^

.. code:: lisp

  (defun enforce-init)

  (defun enforce-mint)


Input data structures
^^^^^^^^^^^^^^^^^^^^^

marmalade_bridge_inbound
~~~~~~~~~~~~~~~~~~~~~~~~~

Handled by ``(create-token)``

.. code:: lisp

  (defschema bridge-inbound-sch
    guard:guard ; Allows to change the destination target, and to mint new tokends
    source:object{bridge-target} ; Initial source target
  )


External functions
^^^^^^^^^^^^^^^^^^

set-source
~~~~~~~~~~
*token-id* ``string`` *dest* ``object{bridge-target}`` *→* ``bool``

Set a new source for the inbound bridge.

The transaction must be signed by the guard given during token creation.

The signature can be scoped by ``(UPDATE-BRIDGE token-id)``

.. code:: lisp

  (use marmalade-ng-bridge.policy-bridge-inbound-guard-mint)
  (set-source "t:EgYRAWXSd4zZlch3B0cLHTSEt4sgYVg5cwKgvP1CoUs"
                   {'ledger:"marmalade-ng.ledger", 'token:"t:DHnN2gtPymAUoaFxtgjxfU83O8fxGHw8-H_P-kkPxjg", 'chain:""})

View functions
^^^^^^^^^^^^^^
get-data
~~~~~~~~
*token-id* ``string``  *→* ``object{bridge-inbound-sch}``

Return the guard and the target of a given token.

.. code:: lisp

  (use marmalade-ng-bridge.policy-bridge-inbound-guard-mint)
  (get-data "t:EgYRAWXSd4zZlch3B0cLHTSEt4sgYVg5cwKgvP1CoUs")


.. code:: json

  {"guard":{"pred":"keys-all",
            "keys":["c9078691a009cca61b9ba2f34a4ebff59b166c87a6b638eb9ed514109ecd43c8"]},
    "source":{"token":"t:ZwihWuXdtTdM1ibAZagrJIo5t3M7Ig8mSKQge49eUVo","ledger":"n_442d3e11cfe0d39859878e5b1520cd8b8c36e5db.ledger","chain":"0"}
  }
