BRIDGE_NAMESPACE = "n_a55cdf159bc9fda0a8af03a71bb046942b1e4faf"
NG_NAMESPACE = "n_442d3e11cfe0d39859878e5b1520cd8b8c36e5db"
NG_INTERFACE_NAMESPACE = "n_5caec7ffe20c6e09fd632fb1ee04468848966332"

DATA_FILE = testnet_data.yaml

KEY_FILES = keys/a35.yaml \
            keys/e2e.yaml \
            keys/e97.yaml

INIT=-D__INIT__

TRANSACTION_FILES = interfaces \
                    bridge \
										policy-bridge-outbound \
										policy-bridge-inbound \
										policy-bridge-inbound-guard-mint \
										policy-bridge-inbound-instant-mint \
										bridge-std-policies \
										helpers

.PRECIOUS: tx_%.yaml .pact/%.pact

all: $(addprefix tx_, $(addsuffix .json, ${TRANSACTION_FILES}))

.pact:
	mkdir -p .pact

%.json: %.yaml
	$(foreach kf,$(KEY_FILES),kda sign $< -k ${kf};)

.pact/%.pact: templates/%.m4 | .pact
	m4 -I../pact -D__BRIDGE_NAMESPACE__=${BRIDGE_NAMESPACE} -D__NG_NAMESPACE__=${NG_NAMESPACE} -D__NG_INTERFACE_NAMESPACE__=${NG_INTERFACE_NAMESPACE} ${INIT} $< > $@

tx_%.yaml: templates/%.tkpl .pact/%.pact
	kda gen -t $< -o $@ -d ${DATA_FILE}

clean:
		rm -rf .pact
		rm -f *.json
		find . -maxdepth 1 -name "*.yaml" |grep -v "_data.yaml" | xargs rm -f
