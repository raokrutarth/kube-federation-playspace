
GLOBAL_CONTEXT=deaas-global-ctx
CLOUD_CONTEXT=tenant1-site1-ctx

gen-install-file:
	cat kubefed/charts/kubefed/crds/crds.yaml > install_out.yml
	cat kubefed/charts/kubefed/charts/controllermanager/crds/crds.yaml >> install_out.yml
	helm template ./kubefed/charts/kubefed/ --set global.scope=Namespaced --kube-context=$(CLOUD_CONTEXT) >> install_out.yml
	cat ./fed-manager-addon.yml >> install_out.yml

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

copy-kubeconfigs:
	# <some-namespace>/<some-pod>:/tmp/bar
	kubectl --context=$(GLOBAL_CONTEXT) cp ~/.kube/*.yml default/

rm-kf:
	# -kubectl -n default delete FederatedTypeConfig --all --context=$(GLOBAL_CONTEXT)

	# -kubectl --context=$(GLOBAL_CONTEXT) -n default delete crd $$( \
	# 	kubectl --context=$(GLOBAL_CONTEXT) -n default get crd | \
	# 	grep -E 'kubefed.io' | \
	# 	awk '{print $$1}' \
	# )

	kubectl --context=$(GLOBAL_CONTEXT) delete -f helm_install_out.yml

	# status after remove
	kubectl --context=$(GLOBAL_CONTEXT) get all

all: check-ctx helm-install
clean: rm-kf