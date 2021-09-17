FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build

FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

COPY --from=builder /app/dist/my-app /usr/share/nginx/html