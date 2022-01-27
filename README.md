# Overview

- `gitignore` (2 files) -> {root level, platforms folder level (terraform ignorefile)}
- `editorconfig` to config editor configuration (required extension in vscode)

# Dockerfile

- Add a `Dockerfile` to containerize the app, with support for multiple environments (test, development & production)

```Dockerfile
FROM node:16-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json package-lock.json ./

RUN NODE_ENV=production npm ci

# Bundle app source
COPY . .

USER node

ENTRYPOINT [ "npm" ]
CMD [ "start" ]

```
- I add some `.dockerignore` to ignore non-relevant file
- I change the code to accept the extra environemnt variable in `index.js`
    ```js
    const ENVIRONMENT = typeof process.env.ENVIRONMENT === 'undefined' ? 'dev' : process.env.ENVIRONMENT;
    const STATSD_PORT = typeof process.env.STATSD_PORT === 'undefined' ? 8125 : parseInt(process.env.STATSD_PORT);
    const STATSD_URL = typeof process.env.STATSD_URL === 'undefined' ? 'localhost' : process.env.STATSD_URL;
    ```
- Add some debug msg in `index.js`
    ```js
    console.log("🚀🚀🚀");
    console.log('[INFO] Run with env: ' + ENVIRONMENT);
    console.log('[INFO] Target URL is: ' + STATSD_URL);
    console.log('[INFO] Target port is: ' + STATSD_PORT);
    ```
- Change start script in `package.json`
    ```json
    "scripts": {
      "test": "echo \"PASS\" && exit 0",
      "start": "node index.js"
    },
    ```
- To create an image as
    ```bash
    docker build . -t bigdev2000/api
    ```
- process.env.`<ENV>` can be pass be passed to Container (pod) by running
    ```bash
    docker run [-e <key>="value"] <image>
    # JS code will take care of ENV var as String **
    ```
    For pod; example in `/k8s/helm/application/api-dev-values.yaml`
    ```yaml
    extraEnv:
      ENVIRONMENT: dev
      STATSD_PORT: 8125
      STATSD_URL: graphite.default.svc.cluster.local
    ```

# Docker-compose

Add a `docker-compose.yml` file to setup Node app, `statsd` & the backend. Applicants can use any backends for `statsd` (eg: `Graphite`).

```yaml
version: "3.8"
services:
  graphite:
    image: graphiteapp/graphite-statsd
    ports:
    - "80:80"
    - "2003-2004:2003-2004"
    - "2023-2024:2023-2024"
    - "8125:8125/udp"
    - "8126:8126"

```

- I use graphite official image to do `docker-compose.yaml`
- On kubernetes platform, I use `/k8s/helm/application/graphite-dev-values.yaml` instead of `docker-compose.yaml` file
