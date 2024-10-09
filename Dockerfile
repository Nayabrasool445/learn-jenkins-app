FROM nginx:alpine
COPY staticweb/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]