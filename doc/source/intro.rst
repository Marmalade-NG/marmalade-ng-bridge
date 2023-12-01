Introduction
============

The bridge is a component that allows the transfer of tokens (NFT or Poly-fungible)
between different ledgers.

5 modes are supported:

- **Marmalade NG <-> another Marmalade NG instance (Bidirectional):** Allow bridging between the public (*official*) Marmalade NG ledger and a private Marmalade ledger. ``token-id`` s must be equal.

- **Marmalade NG <-> same Marmalade NG (Bidirectional):** Allow exchanging a token to another token on the same ledger. This is useful if a creator wants to upgrade his token (for example, to add a new policy).


- **X-chain Marmalade NG <-> same Marmalade NG (Bidirectional):** Allow bridging tokens between chains. ``token-id`` s and ledgers fully qualified names must be equal.


- **Marmalade V1 -> Marmalade NG (Unidirectional):** Allow to upgrade a Marmalade V1 token to a Marmalade NG token.


- **Generic ledger -> Marmalade NG (Unidirectional):** Allow upgrading a token from a third party ledger to Marmalade NG token. Only non-fungible tokens are supported.


In All modes, the token owner (account) and guards are conserved.


.. image:: diagrams/bridge.svg
