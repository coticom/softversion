OUTPUT=softversion
GOCMD=go
GOCLEAN=$(GOCMD) clean
GOMOD=$(GOCMD) mod
all: get_deps build

get_deps:
	@rm -rf vendor/
	@echo "--> Running go mod vendor"
	$(GOMOD) download
	$(GOMOD) vendor

GITTAG=`git describe --tags`
GITHASH=`git rev-parse --short HEAD`

LDFLAGS=-ldflags "-X main.GitTag=${GITTAG} -X main.GitHash=${GITHASH}"

build:
	go build ${LDFLAGS} -o ${OUTPUT}