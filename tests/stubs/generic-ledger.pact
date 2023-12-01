(module generic-ledger GOVERNANCE

  (use marmalade-ng-bridge.bridge)
  (implements marmalade-ng-bridge.generic-burnable-nft-v1-beta1)

  (use marmalade-ng-bridge.generic-burnable-nft-v1-beta1 [burnable-nft-details])

  (defcap GOVERNANCE ()
    true)

  (defcap BURNED-EVENT (token-id:string)
    @event
    true
  )

  (defun burn:bool (token-id:string)
    (require-capability (ALLOW-BURN-GENERIC generic-ledger token-id
                                       {'ledger:"marmalade-ng-A.ledger", 'token:"", 'chain:""}))
    (emit-event (BURNED-EVENT token-id))

  )

  (defconst EXAMPLE-OWNER:string (read-string "example_owner"))

  (defconst EXAMPLE-KEYSET:guard (read-keyset "example_keyset"))

  (defun owner-details:object{burnable-nft-details} (token-id:string)
    {'owner:EXAMPLE-OWNER, 'guard:EXAMPLE-KEYSET})

)
