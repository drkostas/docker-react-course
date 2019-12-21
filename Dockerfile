FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build
# From this Phase we only keep build folder
# So that we don't need to carry over the 
# node dependencies in the production container

# Next Phase
FROM nginx
# Required only for online servers like elasticbeastalk
EXPOSE 80 
# Copy from first phase instead of the local folder
COPY --from=builder /app/build /usr/share/nginx/html