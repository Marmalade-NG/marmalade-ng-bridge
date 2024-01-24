(namespace "free")

(module marm-v1-bridgable-policy GOVERNANCE

  (defcap GOVERNANCE ()
    (enforce-keyset "free.marm-v1-bridgable-policy-gov"))

  (implements kip.token-policy-v1)
  (use kip.token-policy-v1 [token-info])
  ; Dont forget to change the namespace of Marmalade NG Bridge
  (use n_a55cdf159bc9fda0a8af03a71bb046942b1e4faf.bridge)

  (defschema to-token-sch
    dest-token:string
  )

  (deftable to-bridge-table:{to-token-sch})

  (defun register-bridgable:string (v1-token:string ng-token:string)
    (with-capability (GOVERNANCE)
      (write to-bridge-table v1-token {'dest-token:ng-token}))
  )

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
    (with-read to-bridge-table (at 'id token) {'dest-token:=dest-token}
      (require-capability (ALLOW-BURN-V1 marmalade.ledger (at 'id token)
                                       ; Dont forget to change the namespace of Marmalade NG core
                                       {'ledger:"n_442d3e11cfe0d39859878e5b1520cd8b8c36e5db.ledger", 'token:dest-token, 'chain:""})))
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
