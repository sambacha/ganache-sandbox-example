FROM node:12

RUN apt update && apt install -y python-pip

WORKDIR ganache
ENV PATH="./node_modules/.bin:${PATH}"

RUN git clone https://github.com/gnosis/contract-proxy-kit.git gnosis-cpk && \
cd gnosis-cpk && \
git checkout master && \
npm install

RUN git clone https://github.com/gnosis/dex-contracts.git gnosis-dex && \
cd gnosis-dex && \
git checkout master && \
yarn



RUN npm install ganache-cli@6.12.2
RUN npm install ganache-sandbox

COPY . .
RUN bash prepare_db.sh

EXPOSE 8545

CMD ["./node_modules/.bin/ganache-cli", "-d", "--db", "db", "-h", "0.0.0.0", "-i", "50", "-l", "10000000"]
