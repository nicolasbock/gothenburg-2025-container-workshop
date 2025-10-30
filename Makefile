.PHONY: run-app
run-app:
	python3 -m venv venv
	./venv/bin/pip install --upgrade pip
	./venv/bin/pip install -r requirements.txt
	./venv/bin/python app.py

.PHONY: clean
clean:
	rm -rf venv

.PHONY: build-docker
build-docker:
	docker build -t gothenburg-2025-container-workshop .

.PHONY: run-docker
run-docker:
	docker run --publish 8080:8080 --rm gothenburg-2025-container-workshop:latest
