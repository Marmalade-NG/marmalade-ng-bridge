(module v1-bridgable-policy GOVERNANCE

  (defcap GOVERNANCE ()
    true)

  (implements kip.token-policy-v1)
  (use kip.token-policy-v1 [token-info])
  (use marmalade-ng-bridge.bridge)


  (defun enforce-ledger:bool ()
    (enforce-guard (marmalade.ledger.ledger-guard))
  )

  (defun enforce-mint:bool
    ( token:object{token-info}
      account:string
      guard:guard
      amount:decimal
    )
    (enforce-ledger)

  )

  (defun enforce-burn:bool
    ( token:object{token-info}
      account:string
      amount:decimal
    )
    (enforce-ledger)
    (require-capability (ALLOW-BURN-V1 marmalade.ledger (at 'id token)
                                       {'ledger:"marmalade-ng-A.ledger", 'token:"", 'chain:""}))

  )

  (defun enforce-init:bool
    ( token:object{token-info}
    )
    (enforce-ledger)
  )


  (defun enforce-offer:bool
    ( token:object{token-info}
      seller:string
      amount:decimal
      sale-id:string )
    (enforce-ledger)
  )

  (defun enforce-buy:bool
    ( token:object{token-info}
      seller:string
      buyer:string
      buyer-guard:guard
      amount:decimal
      sale-id:string )
    (enforce-ledger)

  )

  (defun enforce-sale-pact:bool (sale:string)
    "Enforces that SALE is id for currently executing pact"
    (enforce (= sale (pact-id)) "Invalid pact/sale id")
  )

  (defun enforce-transfer:bool
    ( token:object{token-info}
      sender:string
      guard:guard
      receiver:string
      amount:decimal )
    (enforce-ledger)
  )

  (defun enforce-crosschain:bool
    ( token:object{token-info}
      sender:string
      guard:guard
      receiver:string
      target-chain:string
      amount:decimal )
    (enforce-ledger)

  )
)
