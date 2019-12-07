FROM node:12.13.1-stretch-slim

WORKDIR /bcrypt

COPY app/ /bcrypt/

RUN npm install && \
    npm run build

CMD ["/bin/bash", "-c", "npm run serve"]
