FROM python:3.10-buster as py-build

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends netcat util-linux \
        vim bash-completion yamllint postgresql-client python3-dev \
        libpq-dev

RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python3 -

COPY . /app
WORKDIR /app
ENV PATH=/opt/poetry/bin:$PATH
RUN ls /opt/poetry

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash && \
    source $HOME/.nvm/nvm.sh && \
    nvm install 14 && \
    nvm use 14 && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends yarn

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 14.20.0
ENV NODE_PATH $NVM_DIR/versions/v$NODE_VERSION/lib/node_modules #Ensure that this is the actual path
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN . $NVM_DIR/nvm.sh && \
  nvm install $NODE_VERSION && npm install -g npm@6.14.13 && \
  npm install -g cross-env
