bridge-std-polices
------------------

Description
^^^^^^^^^^^

Transform a list of bridge policies into a strings, or a string into a list of policies.

.. list-table:: Policies
  :widths: 25 25 25
  :header-rows: 1

  * - Outbound Policy
    - Inbound Policy
    - String

  * - policy-bridge-outbound
    - /
    - **OUTBOUND**

  * - policy-bridge-outbound
    - policy-bridge-inbound
    - **BIDIR-NO-MINT**

  * - policy-bridge-outbound
    - policy-bridge-inbound-instant-mint
    - **BIDIR-INSTANT-MINT**

  * - policy-bridge-outbound
    - policy-bridge-inbound-guard-mint
    - **BIDIR-GUARD-MINT**

  * - /
    - policy-bridge-inbound
    - **INBOUND-NO-MINT**

  * - /
    - policy-bridge-inbound-instant-mint
    - **INBOUND-INSTANT-MINT**

  * - /
    - policy-bridge-inbound-guard-mint
    - **INBOUND-GUARD-MINT**


Functions
^^^^^^^^^

bridging-policies
~~~~~~~~~~~~~~~~~
*type* ``string`` *→* ``[module{token-policy-ng-v1}]``

Transform a string to a list of policies.


.. code:: lisp

  (use marmalade-ng-bridge.bridge-std-policies)
  (bridging-policies "BIDIR-GUARD-MINT")
    > [policy-bridge-outbound, policy-bridge-inbount-guard-mint]


from-bridging-policies
~~~~~~~~~~~~~~~~~~~~~~
*policy-list* ``[module{token-policy-ng-v1}]`` *→*  `string``

Transform a list of policies into a string.


.. code:: lisp

  (use marmalade-ng-bridge.bridge-std-policies)
  (bridging-policies [policy-bridge-outbound, policy-bridge-inbount-guard-mint, marmalade-ng.policy-non-fungible])
    > "BIDIR-GUARD-MINT"
