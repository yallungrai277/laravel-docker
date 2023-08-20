ARG NGINX_IMAGE

FROM ${NGINX_IMAGE}

# nginx user
ENV USER=laravel
# nginx group
ENV GROUP=laravel

RUN mkdir -p /var/www/html

ADD ./docker/nginx/conf/default.conf /etc/nginx/conf.d/default.conf

# Replace the default user with 'laravel' in the nginx.conf file
RUN sed -i "s/user www-data/user ${USER}/" /etc/nginx/nginx.conf

# Add user passing in a group laravel, attaching it with the default bin/sh (shell) with a user name laravel.
RUN adduser -g ${GROUP} -s /bin/sh -D ${USER}
