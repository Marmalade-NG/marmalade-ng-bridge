(module bridge-std-policies GOVERNANCE

  ;-----------------------------------------------------------------------------
  ; Governance
  ;-----------------------------------------------------------------------------
  (defconst ADMIN-KEYSET:string (read-string "admin_keyset"))
  (defcap GOVERNANCE ()
    (enforce-keyset ADMIN-KEYSET))

  ;-----------------------------------------------------------------------------
  ; Helper function
  ;-----------------------------------------------------------------------------
  (defun bridging-policies:[module{__NG_NAMESPACE__.token-policy-ng-v1}] (type:string)
    (cond
      ((= type "") [])
      ((= type "OUTBOUND") [policy-bridge-outbound])
      ((= type "INBOUND-NO-MINT") [policy-bridge-inbound])
      ((= type "INBOUND-INSTANT-MINT") [policy-bridge-inbound-instant-mint])
      ((= type "INBOUND-GUARD-MINT") [policy-bridge-inbound-guard-mint])
      ((= type "BIDIR-NO-MINT") [policy-bridge-outbound policy-bridge-inbound])
      ((= type "BIDIR-INSTANT-MINT") [policy-bridge-outbound policy-bridge-inbound-instant-mint])
      ((= type "BIDIR-GUARD-MINT") [policy-bridge-outbound policy-bridge-inbound-guard-mint])
      [(enforce false "Unrecognized bridge type")])
  )
)
