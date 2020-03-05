
build:
	go build *.go


get-cluster-credentials:
	gcloud container clusters get-credentials prowdemo --project=testbed1-249617 --zone=us-central1-a


update-plugins: get-cluster-credentials
	kubectl create configmap plugins --from-file=plugins.yaml=plugins.yaml --dry-run -o yaml | kubectl replace configmap plugins -f -
