
GLOBAL_CONTEXT=deaas-global-ctx
CLOUD_CONTEXT=tenant1-site1-ctx

gen-helm-file:
	helm template ./kubefed/charts/kubefed/ --set global.scope=Namespaced --kube-context=$(CLOUD_CONTEXT) > helm_install_out.yml

check-ctx:
	# check both clusters are available

	# cloud cluster context test
	kubectl --context=$(CLOUD_CONTEXT) get all

	# global cluster context check
	kubectl --context=$(GLOBAL_CONTEXT) get all

helm-install:
	kubectl --context=$(GLOBAL_CONTEXT) apply -f helm_install_out.yml

	# status after install
	kubectl --context=$(GLOBAL_CONTEXT) get all

kf-join:
	kubefedctl join mysite --cluster-context $(CLOUD_CONTEXT) \
		--host-cluster-context $(GLOBAL_CONTEXT) --v=2 \
		--kubefed-namespace=default \
		--set global.scope=Namespaced

rm-kf:
	-kubectl -n default delete FederatedTypeConfig --all --context=$(GLOBAL_CONTEXT)

	-kubectl --context=$(GLOBAL_CONTEXT) -n default delete crd $$( \
		kubectl --context=$(GLOBAL_CONTEXT) -n default get crd | \
		grep -E 'kubefed.io' | \
		awk '{print $$1}' \
	)

	kubectl --context=$(GLOBAL_CONTEXT) delete -f helm_install_out.yml

	# status after remove
	kubectl --context=$(GLOBAL_CONTEXT) get all

all: check-ctx helm-install
clean: rm-kf