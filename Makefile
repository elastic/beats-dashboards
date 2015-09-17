VERSION?=$(shell git rev-parse --abbrev-ref HEAD)

.PHONY: dist
dist:
	git archive --format tar.gz --prefix beats-dashboards-$(VERSION)/ -o ../beats-dashboards-$(VERSION).tar.gz HEAD
