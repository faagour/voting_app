#FROM nginx:alpine

#COPY nginx.conf /etc/nginx/nginx.conf

#EXPOSE 80

#CMD ["nginx", "-g", "daemon off;"]


#FROM --platform=linux/amd64 nginx:alpine
#WORKDIR /usr/share/nginx/html
#RUN rm -rf ./*
#COPY . .
#EXPOSE 81
#CMD ["nginx", "-g", "daemon off;"]
# Use the official Nginx image
FROM nginx

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom configuration file into the container
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 8000
EXPOSE 80

# Command to start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]