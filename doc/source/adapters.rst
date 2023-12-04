Ledgers adapters
=================

Marmalade NG public ledger
--------------------------

The bridge namespace includes 4 NG policies, to connect with the bridge:
  - The outbound policy
  - 3 flavors of inbound policies (only one must be used)

This allows a lot of combinations to adapt the token's behavior to a lot of use cases.


Outbound policy
^^^^^^^^^^^^^^^
**Important note:** This policy is incompatible with the Marmalade NG's ``DISABLE-BURN`` policy.
Including this policy will disable the possibility of bridging tokens out the ledger. Hopefully, the outbound bridge policy
can efficiently replace the original ``DISABLE-BURN`` policy by using the null target object.

The outbound policy is in charge of calling the ``(ALLOW-BURN   )`` capability of the bridge.

The outbound policy is initialized at token creation time with a guard and an initial target object.
The target object can be modified later by using the function ``set-destination``

Inbound policies
^^^^^^^^^^^^^^^^
**Important note:** These policies are incompatible with the Marmalade NG's ``INSTANT-MINT`` policy, or tokens guarded by a mint-guard in the ``GUARDS`` policy.

The inbound policies are in charge of calling the ``(ALLOW-MINT   )`` capability of the bridge.

The inbound policies are initialized at token creation time with a guard and an initial target object.
The target object can be modified later by using the function ``set-source``

The most simple inbound policy is called :ref:`POLICY-BRIDGE-INBOUND` . This policy does not allow the minting of tokens outside a bridging context.
Sometimes this behavior is expected, but it exhibits an issue: how to initially mint tokens from nothing ?
Moreover ,the inbound policies automatically take precedence over standard minting policies like ``INSTANT-MINT``.

That's why, two extra variations of the basic inbound policy are provided:

- The policy :ref:`POLICY-BRIDGE-INBOUND-INSTANT-MINT` is a mix of the basic inbound policy and ``INSTANT-MINT``. It allows minting tokens by bridging or just after creation.

- The policy :ref:`POLICY-BRIDGE-INBOUND-GUARD-MINT` is a mix of the basic inbound policy and ``GUARD``. It allows minting tokens by signing the transaction with the registered guard.


The module bridge-std-policies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This module helps to transform:

- a stringified bridge specifications into a list of policies.

- or to transform a list of policies into a bridge specification.


Example of a bridge architecture
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Ledger A is the initial minting ledger, while Ledger B is a bridged only ledger.

.. image:: diagrams/example_ng_policies.svg



Marmalade NG private ledgers
----------------------------
The official deployment of the bridge policies is statically linked to the official Marmalade NG.

If someone wants to make them work with a private ledger, he has to deploy other instances of the bridge policies
linked to his ledger.
This can be easily done by following the instructions in the Readme file in the ``deployment`` directory.


Marmalade V1
------------

Helper
^^^^^^
To bridge tokens from a Marmalade V1 ledger, a helper (gateway) module must be used.
The reason is that the poly-fungible-v2 interface standardized in **KIP-0013** doesn't expose the ``burn``
function.

The helper is just a simple module that implements the ``marmalade-burn-helper-v1`` interface to expose the burn function.
A standard helper is provided by the official bridge deployment on chain 8, linked to the official ``marmalade.ledger``

To bridge tokens from a third party Marmalade V1 ledger, a third party helper must be deployed. There is no such difficulty.
Just deploy a copy of the existing module by changing the FQN of the targeted ledger.

Adapt the policy
^^^^^^^^^^^^^^^^

To bridge a token, its policy must be changed to authorize burning and call the bridge's capability ``(ALLOW-BURN-V1)``

Example of an ``enforce-burn`` function of a Marmalade V1 policy, allowing bridging.

.. code-block:: lisp

  (defun enforce-burn:bool
    ( token:object{token-info}
      account:string
      amount:decimal
    )
    (enforce-ledger)
    (require-capability (ALLOW-BURN-V1 marmalade.ledger (at 'id token)
                                       {'ledger:"marmalade-ng-A.ledger", 'token:"", 'chain:""}))
  )

Other ledgers
-------------

TODO

Outbound considerations
-----------------------

TODO
