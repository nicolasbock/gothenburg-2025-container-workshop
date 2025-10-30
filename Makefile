.PHONY: run-app
run-app:
	python3 -m venv venv
	./venv/bin/pip install --upgrade pip
	./venv/bin/pip install -r requirements.txt
	./venv/bin/python app.py

.PHONY: clean
clean:
	rm -rf venv
	rockcraft clean
	docker rmi gothenburg-2025-container-workshop:docker || true
	docker rmi gothenburg-2025-container-workshop:rock || true

.PHONY: build-docker
build-docker:
	docker build -t gothenburg-2025-container-workshop:docker .

.PHONY: run-docker
run-docker: build-docker
	docker run --publish 8080:8080 --rm gothenburg-2025-container-workshop:docker

.PHONY: build-rock
build-rock:
	rockcraft pack --verbosity=debug
	rockcraft.skopeo --insecure-policy copy \
        oci-archive:gothenburg-2025-container-workshop_0.1_amd64.rock \
        docker-daemon:gothenburg-2025-container-workshop:rock

.PHONY: run-rock
run-rock: build-rock
	docker run --publish 8080:8080 --rm gothenburg-2025-container-workshop:rock
