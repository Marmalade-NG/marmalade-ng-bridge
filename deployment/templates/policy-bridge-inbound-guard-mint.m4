(namespace "__BRIDGE_NAMESPACE__")

include(ng-policies/policy-bridge-inbound-guard-mint.pact)dnl
"Module loaded"

ifdef(`__INIT__',dnl
(create-table bridge-data)
)
