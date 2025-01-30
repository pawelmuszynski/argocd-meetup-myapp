FROM nginx:1.27.3

ARG BUILD_VERSION=None
RUN echo ${BUILD_VERSION}
RUN echo "<html><head><title>MYAPP</title></head><body><h1>MYAPP</h1><h2>version: ${BUILD_VERSION}</h2></body></html>" > /usr/share/nginx/html/index.html
