FROM node:8.16.1-jessie-slim

WORKDIR /bcrypt

COPY app/ /bcrypt/

RUN npm install && \
    npm run build

CMD ["/bin/bash", "-c", "npm run serve"]