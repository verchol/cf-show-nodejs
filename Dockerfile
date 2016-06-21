FROM ubuntu:16.04

WORKDIR /server
ENV SHELL /bin/bash

RUN apt-get update && apt-get install -y openssl curl build-essential libssl-dev vim zip unzip gawk && echo -e "\n----\nPASS - apt-get\n----\n" && \
curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash && echo -e "\n----\nPASS - install nvm \n----\n" && \
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \
. "$NVM_DIR/nvm.sh" && echo -e "\n----\nPASS - nvm environ\n----\n" && \
nvm install v5.7.1 && echo -e "\n----\nPASS - node version install \n----\n" &&  \
nvm use 5.7.1 && echo -e "\n----\nPASS - nvm use\n----\n" && \
nvm alias default node && echo -e "\n----\nPASS - nvm alias\n----\n" && 

COPY index.js package.json server/
RUN npm install

ENV NVM_BIN /root/.nvm/versions/node/v5.7.1/bin
ENV PATH $NVM_BIN:$PATH

EXPOSE 3000

CMD node index.js
