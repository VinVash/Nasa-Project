FROM node:lts-alpine

WORKDIR /app

# for copying both the package.json and package-lock.json files to the app folder which is set as the WORKDIR.
COPY package*.json ./

COPY client/package*.json client/
RUN npm run install-client --only=production

COPY server/package*.json server/
RUN npm run install-server --only=production

COPY client/ client/
RUN npm run build --prefix client

COPY server/ server/

USER node

CMD [ "npm", "start", "--prefix", "server" ]

EXPOSE 8000