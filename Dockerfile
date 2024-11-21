FROM node:latest
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY my-app .

FROM nginx:alpine
COPY --from=build /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

