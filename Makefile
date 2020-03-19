
build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build *.go


get-cluster-credentials:
	gcloud container clusters get-credentials prowtest1 --project=testbed1-249617 --zone=us-central1-c


update-plugins: get-cluster-credentials
	kubectl create configmap plugins --from-file=plugins.yaml=plugins.yaml --dry-run -o yaml | kubectl replace configmap plugins -f -

update-configs: get-cluster-credentials
	kubectl create configmap config --from-file=config.yaml=config.yaml --dry-run -o yaml | kubectl replace configmap config -f -

check-config: ## Check prow config.yaml for errors
	./checkconfig  --config-path=config.yaml -strict
