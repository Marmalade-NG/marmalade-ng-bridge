(module marmalade-std-helper-v1 GOVERNANCE
  (implements __BRIDGE_NAMESPACE__.marmalade-burn-helper-v1-beta1)

  (defcap GOVERNANCE ()
    (enforce false "Not upgradable"))

  (defun burn:bool (token:string account:string amount:decimal)
    (marmalade.ledger.burn token account amount))
)
