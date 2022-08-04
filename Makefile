.DEFAULT_TARGET=help
VERSION:=$(shell cat VERSION)

## help: Display list of commands
.PHONY: help
help: Makefile
	@sed -n 's|^##||p' $< | column -t -s ':' | sed -e 's|^| |'

## lint: Lint source code
.PHONY: lint
lint:
	pre-commit run -a

## release: Release a new version
.PHONY: release
release: lint
	git tag -a "v$(VERSION)" -m "$(VERSION)"
	git push origin "v$(VERSION)"
