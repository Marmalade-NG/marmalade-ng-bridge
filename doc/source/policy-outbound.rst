.. _POLICY-BRIDGE-OUTBOUND:

policy-bridge-outbound
----------------------

Description
^^^^^^^^^^^

Allows a token to be bridged out, according to the target object.

**Note:** Incompatible with the ``DISABLE-BURN`` policy, or a guarded burn of the ``GUARD`` policy.

Implemented hooks
^^^^^^^^^^^^^^^^^

.. code:: lisp

  (defun enforce-init)

  (defun enforce-burn)


Input data structures
^^^^^^^^^^^^^^^^^^^^^

marmalade_bridge_outbound
~~~~~~~~~~~~~~~~~~~~~~~~~

Handled by ``(create-token)``

.. code:: lisp

  (defschema bridge-outbound-sch
    guard:guard ; Allows to change the destination target
    dest:object{bridge-target} ;Initial destination target
  )


External functions
^^^^^^^^^^^^^^^^^^

set-destination
~~~~~~~~~~~~~~~
*token-id* ``string`` *dest* ``object{bridge-target}`` *→* ``bool``

Set a new destination for the outbound bridge.

The transaction must be signed by the guard given during token creation.

The signature can be scoped by ``(UPDATE-BRIDGE token-id)``

.. code:: lisp

  (use marmalade-ng-bridge.policy-bridge-outbound)
  (set-destination "t:EgYRAWXSd4zZlch3B0cLHTSEt4sgYVg5cwKgvP1CoUs"
                   {'ledger:"marmalade-ng.ledger", 'token:"t:DHnN2gtPymAUoaFxtgjxfU83O8fxGHw8-H_P-kkPxjg", 'chain:""})

View functions
^^^^^^^^^^^^^^
get-data
~~~~~~~~
*token-id* ``string``  *→* ``object{bridge-outbound-sch}``

Return the guard and the target of a given token.

.. code:: lisp

  (use marmalade-ng-bridge.policy-bridge-outbound)
  (get-data "t:EgYRAWXSd4zZlch3B0cLHTSEt4sgYVg5cwKgvP1CoUs")


.. code:: json

  {"guard":{"pred":"keys-all",
            "keys":["c9078691a009cca61b9ba2f34a4ebff59b166c87a6b638eb9ed514109ecd43c8"]},
    "dest":{"token":"t:ZwihWuXdtTdM1ibAZagrJIo5t3M7Ig8mSKQge49eUVo","ledger":"n_442d3e11cfe0d39859878e5b1520cd8b8c36e5db.ledger","chain":"0"}
  }
