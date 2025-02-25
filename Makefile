.PHONY: buildkind buildimage

buildkind: 
	kubectl create ns monitoring
	kubectl apply -f kub-objects/metric-server.yaml
	kubectl apply -f node-exporter
	kubectl apply -f kub-objects/rbac-scheduler.yaml
	kubectl apply -f kub-objects/hybrid-scheduler-deploy.yaml

buildimage:
	docker build -t miadan/hybrid-scheduler:v0.0.0 .
