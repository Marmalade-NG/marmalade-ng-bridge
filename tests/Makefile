all: tests

PACT_BIN:=pact

INIT_FILES=init/init-marmalade-ng.repl

TEST_FILES=test-bridge-loop.repl

COMMON_FILES=bridge.pact \
             bridge-utils.pact \
						 helpers/marmalade-std-helper.pact

POLICIES=policy-bridge-inbound.pact \
         policy-bridge-outbound.pact \
				 policy-bridge-inbound-guard-mint.pact \
				 policy-bridge-inbound-instant-mint.pact \
				 bridge-std-policies.pact


PACT_FILES= $(addprefix .pact/, ${COMMON_FILES})
PACT_POLICIES_A = $(addprefix .pact/policies/A_, ${POLICIES})
PACT_POLICIES_B = $(addprefix .pact/policies/B_, ${POLICIES})

MACROS=-D__NG_INTERFACE_NAMESPACE__=kip \
			 -D__BRIDGE_NAMESPACE__=marmalade-ng-bridge

.pact:
	mkdir -p .pact
	mkdir -p .pact/helpers

.pact/policies: .pact
	mkdir -p .pact/policies

.pact/%.pact: ../pact/%.pact .pact
	m4 -I../pact ${MACROS} $< > $@

.pact/policies/A_%.pact: ../pact/ng-policies/%.pact .pact/policies
	m4 -I../pact ${MACROS} -D__NG_NAMESPACE__=marmalade-ng-A $< > $@

.pact/policies/B_%.pact: ../pact/ng-policies/%.pact .pact/policies
	m4 -I../pact ${MACROS} -D__NG_NAMESPACE__=marmalade-ng-B $< > $@

gen: ${PACT_FILES} ${PACT_POLICIES_A} ${PACT_POLICIES_B}

tests: .pact ${PACT_FILES} ${PACT_POLICIES_A} ${PACT_POLICIES_B}
	${PACT_BIN} test-bridge-loop.repl
	${PACT_BIN} test-bridge-x-chain.repl
	${PACT_BIN} test-bridge-v1.repl 2>&1 | grep  -v "Using deprecated native create-module-guard"
	${PACT_BIN} test-bridge-generic-interface.repl
	${PACT_BIN} test-std-policies.repl

check_types: ${PACT_FILES} ${PACT_POLICIES_A} ${PACT_POLICIES_B}
	pact check_types.repl

clean:
	rm  -rf .pact
