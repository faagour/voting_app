#FROM nginx:alpine

#COPY nginx.conf /etc/nginx/nginx.conf

#EXPOSE 80

#CMD ["nginx", "-g", "daemon off;"]


FROM --platform=linux/amd64 nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY . .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
