.PHONY: build publish build-centos-stream-10 publish-centos-stream-10

build:
	./build.sh

publish:
	./publish.sh

build-centos-stream-10:
	./build-centos-stream-10.sh

publish-centos-stream-10:
	./publish-centos-stream-10.sh
