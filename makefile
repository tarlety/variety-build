SHELL=/bin/bash

.PHONY: build
build:
	rm -rf ${PWD}/build/deb ${PWD}/secret
	mkdir -p ${PWD}/build/deb ${PWD}/secret
	gpg --export-secret-keys --armor ppa > ${PWD}/secret/key.sec
	docker build -t variety-build .
	docker run -it --rm -v ${PWD}/build/deb:/packages/variety/deb -v ${PWD}/secret:/secret --name variety-build variety-build

.PHONY: clean
clean:
	rm -rf ${PWD}/secret
	docker rmi variety-build

