(module policy-bridge-inbound GOVERNANCE
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
  (deftable bridge-data:{bridge-inbound-sch})

  ;-----------------------------------------------------------------------------
  ; Capabilities
  ;-----------------------------------------------------------------------------
  (defcap UPDATE-BRIDGE (token-id:string)
    @event
    (with-read bridge-data token-id {'guard:=g}
      (enforce-guard g))
  )

  ;-----------------------------------------------------------------------------
  ; Input data
  ;-----------------------------------------------------------------------------
  (defun read-bridge-inbound-msg:object{bridge-inbound-sch} (token:object{token-info})
    (enforce-get-msg-data "bridge_inbound" token))

  ;-----------------------------------------------------------------------------
  ; Policy hooks
  ;-----------------------------------------------------------------------------
  (defun rank:integer ()
    RANK-HIGH-PRIORITY)

  (defun enforce-init:bool (token:object{token-info})
    (require-capability (__NG_NAMESPACE__.ledger.POLICY-ENFORCE-INIT token policy-bridge-inbound))
    (insert bridge-data (at 'id token) (read-bridge-inbound-msg token))
    true
  )

  (defun enforce-mint:bool (token:object{token-info} account:string amount:decimal)
    (bind token {'id:=token-id}
      (with-read bridge-data token-id {'source:=src-target}
        (enforce-target-not-null src-target)
        (require-capability (ALLOW-MINT __NG_NAMESPACE__.ledger token-id amount src-target))))
  )

  (defun enforce-burn:bool (token:object{token-info} account:string amount:decimal)
    true)

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


  (defun get-data:object{bridge-inbound-sch} (token-id:string)
    (read bridge-data token-id)
  )

  (defun set-source:bool (token-id:string source:object{bridge-target})
    (with-capability (UPDATE-BRIDGE token-id)
      (update bridge-data token-id {'source:source})
      true)
  )

  (defun remove-source:bool (token-id:string)
    (set-source token-id NULL-TARGET)
  )
)
