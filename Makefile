IMAGE_TAG = localhost/bump3version_test

test:
	docker build -t ${IMAGE_TAG} .
	docker run --rm ${IMAGE_TAG}

local_test:
	PYTHONPATH=. pytest tests/

lint:
	pip install pylint
	pylint bumpversion

debug_test:
	docker build -t ${IMAGE_TAG} .
	docker run -it --rm ${IMAGE_TAG} /bin/bash

clean:
	rm -rf dist build *.egg-info

dist:	clean
	python3 setup.py sdist bdist_wheel

upload:
	twine upload dist/*

.PHONY: dist upload test debug_test
