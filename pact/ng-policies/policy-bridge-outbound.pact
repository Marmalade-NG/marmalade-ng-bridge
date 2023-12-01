(module policy-bridge-outbound GOVERNANCE
  (implements __NG_NAMESPACE__.token-policy-ng-v1)
  (use __NG_NAMESPACE__.token-policy-ng-v1 [token-info])
  (use __NG_NAMESPACE__.util-policies)
  (use __BRIDGE_NAMESPACE__.bridge-utils)
  (use __BRIDGE_NAMESPACE__.bridge)

  ;-----------------------------------------------------------------------------
  ; Governance
  ;-----------------------------------------------------------------------------
  (defconst ADMIN-KEYSET:string (read-string "admin_keyset"))
  (defcap GOVERNANCE ()
    (enforce-keyset ADMIN-KEYSET))

  ;-----------------------------------------------------------------------------
  ; Table
  ;-----------------------------------------------------------------------------
  (deftable bridge-data:{bridge-outbound-sch})

  ;-----------------------------------------------------------------------------
  ; Capabilities
  ;-----------------------------------------------------------------------------
  (defcap UPDATE-BRIDGE (token-id:string)
    @event
    (with-read bridge-data token-id {'guard:=g}
      (enforce-guard g))
  )

  (defun read-bridge-outbound-msg:object{bridge-outbound-sch} (token:object{token-info})
    (enforce-get-msg-data "bridge_outbound" token))

  ;-----------------------------------------------------------------------------
  ; Policy hooks
  ;-----------------------------------------------------------------------------
  (defun rank:integer ()
    RANK-HIGH-PRIORITY)

  (defun enforce-init:bool (token:object{token-info})
    (require-capability (__NG_NAMESPACE__.ledger.POLICY-ENFORCE-INIT token policy-bridge-outbound))
    (insert bridge-data (at 'id token) (read-bridge-outbound-msg token))
    true
  )

  (defun enforce-mint:bool (token:object{token-info} account:string amount:decimal)
    true)

  (defun enforce-burn:bool (token:object{token-info} account:string amount:decimal)
    (bind token {'id:=token-id}
      (with-read bridge-data token-id {'dest:=destination-target}
        (enforce-target-not-null destination-target)
        (require-capability (ALLOW-BURN __NG_NAMESPACE__.ledger token-id destination-target))))
  )

  (defun enforce-transfer:bool (token:object{token-info} sender:string receiver:string amount:decimal)
    true)

  (defun enforce-sale-offer:bool (token:object{token-info} seller:string amount:decimal timeout:time)
    false)

  (defun enforce-sale-withdraw:bool (token:object{token-info})
    true)

  (defun enforce-sale-buy:bool (token:object{token-info} buyer:string)
    true)

  (defun enforce-sale-settle:bool (token:object{token-info})
    true)


  (defun get-data:object{bridge-outbound-sch} (token-id:string)
    (read bridge-data token-id)
  )

  (defun set-destination:bool (token-id:string dest:object{bridge-target})
    (with-capability (UPDATE-BRIDGE token-id)
      (update bridge-data token-id {'dest:dest})
      true)
  )

  (defun remove-destination:bool (token-id:string)
    (set-destination token-id NULL-TARGET)
  )
)
