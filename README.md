# Gothenburg 2025: Mini Workshop

## Introduction & Setup

- We will build OCI compliant container images for a simple Python application
- We will compare two approaches: (1) Using a `Dockerfile` and (2) using `rockcraft.yaml`
- We will start with `Dockerfile` and build the container image
- We will verify that it runs correctly
- We will convert the `Dockerfile` to `rockcraft.yaml`
- We will discuss differences and potential challenges
- We will verify the Rock
- We will discuss key differences between the two approaches

## The application

([app.py](app.py))

```python
from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    # Demonstrating use of an environment variable
    greeting = os.environ.get("GREETING", "Hello")
    return f"{greeting} from the container!"

if __name__ == '__main__':
    # Run on a non-default port to require explicit configuration
    app.run(host='0.0.0.0', port=8080)
```

## Imperative Build: The Dockerfile

Create a functional [`Dockerfile`](Dockerfile) for the application.

1. Install dependencies
2. Set the environment variable for the app (can be overridden at runtime)
3. Expose the port the app runs on
4. Define the command to run the application

## Declarative Build: The rockcraft.yaml

Convert the [`Dockerfile`](Dockerfile) logic to a [`rockcraft.yaml`](rockcraft.yaml) and build a Rock.

Key Concepts:

- base image ([Dockerfile](Dockerfile#L1) vs [rockcraft.yaml](rockcraft.yaml#L2))
- parts section for installation
  **CRITICAL DIFFERENCE**: Explaining Pebble as the default entrypoint and defining services in the services section instead of using `CMD/ENTRYPOINT`.
- pack the image (`rockcraft pack`)
- use `Skopeo` to convert and load the .rock file into the Docker daemon

## Comparison & Verification

### Verify the identical behavior and examine the image differences.

- Run the Rock image and confirm it runs the application identically to the Docker-built image.

### Deep Dive

- Compare docker history <docker_image> vs. inspecting the contents of the built Rock
- Discuss the layering model, the presence of Pebble in the Rock, and how environment variables/commands are handled
