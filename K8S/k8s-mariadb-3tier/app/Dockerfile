FROM node:16-alpine
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci  --omit=dev
COPY app.js .
EXPOSE 3000
CMD ["node", "app.js"]
