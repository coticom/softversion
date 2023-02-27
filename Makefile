OUTPUT=softversion

GITTAG=`git describe --tags`
GITHASH=`git rev-parse --short HEAD`
BUILD_TIME=`date +%FT%T%z`

LDFLAGS=-ldflags "-X main.GitTag=${GITTAG} -X main.BuildTime=${BUILD_TIME} -X main.GitHash=${GITHASH}"

all:
	go build ${LDFLAGS} -o ${OUTPUT} main.go