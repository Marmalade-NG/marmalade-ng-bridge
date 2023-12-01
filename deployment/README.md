# Marmalade-NG - Deployment

## Required tools
  - make (already installed on most Unix flavors)
  - m4 (already installed on most Unix flavors)
  - kda tool (https://github.com/kadena-io/kda-tool)
  - optional : jq tool


## Prerequisites
  - An already created namespace (with the associated key)
  - An already on-chain defined keyset (with the associated key)
  - A funded account with enough KDA to pay deployment fees (and the associated key)

All keys must reside in the keys directory in plain YAML format. Using others key types (eg: Chainweaver keys) would require to slightly modify the Makefile.


## Configure the deployment

Modify the data.yaml file according to your parameters:
  - chain
  - network
  - gas paying account
  - keys

Modify the Makefile:
  - `BRIDGE_NAMESPACE` variable
  - `NG_NAMESPACE` variable (namespace of Marmalade NG)
  - `NG_INTERFACE_NAMESPACE` variable (namespace of Marmalade NG ng-poly-fungible-v1 interface)

  - uncomment the line `INIT=-D__INIT__` if it the first deployment and you need to initialize the modules.
  - List of signing keys

## Generate the transactions files

Just do:
```sh
make
```

## Deploy interfaces
```sh
kda send tx_interfaces.json
```
before proceeding to the next step you can verify that everything is ok and has been deployed.

```sh
kda poll tx_interfaces.json |jq
```

## Deploy the bridge
```sh
kda send tx_bridge.json
```
before proceeding to the next step you can verify that everything is ok and has been deployed.

```sh
kda poll tx_bridge.json | jq
```

## Deploy policies
```sh
kda send tx_policy-*.json
```
before proceeding to the next step you can verify that everything is ok and has been deployed.

```sh
for TRX in tx_policy-*.json; do kda poll $TRX |jq;done
```

## Deploy std-policies and helpers
```sh
kda send tx_bridge-std-policies.json tx_helpers.json
```
You can verify that the module has been well deployed.

```sh
kda poll tx_bridge-std-policies.json | jq
kda poll tx_helpers.json | jq
```
