# Stage 1: just hold your static files
FROM alpine:3.20 AS static
WORKDIR /app
COPY site/ ./

# Stage 2: serve them with nginx
FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=static /app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
