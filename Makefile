.PHONY: default fmt fmt-check install test vet docker clean

BINARY="app"
VERSION=v0.0.1beta1
BUILD=`date +%FT%T%z`
COMMIT=`git rev-parse --short HEAD || echo ""`
GOVERSION=`go version`

PACKAGES=`go list ./... | grep -v /vendor/`
VETPACKAGES=`go list ./... | grep -v /vendor/ | grep -v /examples/`
GOFILES=`find . -name "*.go" -type f -not -path "./vendor/*"`

PREFIX="github.com/rnben/app"
LDFLAGS="-X main.Version=$(VERSION) \
	-X $(PREFIX)/build.Time=$(BUILD) \
	-X $(PREFIX)/build.Commit=$(COMMIT) \
	-X 'main.goversion=$(GOVERSION)'"

default:
	@echo $(GOVERSION)
	@echo $(LDFLAGS)
	@go build -ldflags ${LDFLAGS} -o ${BINARY} -tags=jsoniter

list:
	@echo ${PACKAGES}
	@echo ${VETPACKAGES}
	@echo ${GOFILES}

fmt:
	@gofmt -s -w ${GOFILES}

fmt-check:
	@diff=?(gofmt -s -d $(GOFILES)); \
	if [ -n "$$diff" ]; then \
		echo "Please run 'make fmt' and commit the result:"; \
		echo "$${diff}"; \
		exit 1; \
	fi;

install:
	@govendor sync -v

test:
	@go test -cpu=1,2,4 -v -tags integration ./...

vet:
	@go vet $(VETPACKAGES)

clean:
	@if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi
