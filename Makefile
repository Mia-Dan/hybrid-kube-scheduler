.PHONY: buildkind buildimage

buildkind: buildimage
	kubectl create ns monitoring
	kubectl run iperf3 --image=networkstatic/iperf3 --port=5201
	kubectl run metric-server --image=k8s.gcr.io/metrics-server/metrics-server:v0.6.1
	kubectl run hybrid-scheduler --image=miadan/hybrid-scheduler:v0.0.0
	kubectl run nginx --image=nginx:alpine
	kubectl apply -f kub-objects/metric-server.yaml
	kubectl apply -f node-exporter
	kubectl apply -f kub-objects/rbac-scheduler.yaml
	kubectl apply -f kub-objects/hybrid-scheduler-deploy.yaml

buildimage:
	docker build -t miadan/hybrid-scheduler:v0.0.0 .
