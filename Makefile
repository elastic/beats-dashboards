VERSION?=$(shell git rev-parse --abbrev-ref HEAD)

.PHONY: dist
dist:
	git archive --format zip --prefix beats-dashboards-$(VERSION)/ -o ../beats-dashboards-$(VERSION).zip HEAD

.PHONY: upload
upload: dist
	aws s3 cp --acl public-read ../beats-dashboards-$(VERSION).zip s3://download.elasticsearch.org/beats/dashboards/
