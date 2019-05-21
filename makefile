SHELL=/bin/bash

.PHONY: build
build:
	rm -rf ${PWD}/deb ${PWD}/secret
	mkdir -p ${PWD}/deb ${PWD}/secret
	gpg --export-secret-keys --armor ppa > ${PWD}/secret/key.sec
	docker build -t variety-build .
	docker run -it --rm -v ${PWD}/deb:/packages/variety/deb -v ${PWD}/secret:/secret --name variety-build variety-build

.PHONY: clean
clean:
	rm -rf ${PWD}/secret
	docker rmi variety-build

