FROM wordpress:php7.2-fpm-alpine

RUN apk add --update --no-cache nginx && \
  curl -o /etc/nginx/nginx.conf https://raw.githubusercontent.com/nginxinc/docker-nginx/master/stable/alpine/nginx.conf && \
  docker-php-ext-install calendar && \
  docker-php-ext-enable calendar

COPY nginx.conf /etc/nginx/conf.d/default.conf

# ENTRYPOINT of php-fpm image does nothing but proxy CMD to php-fpm if CMD is
# only --some-parameter, hence it can be ignored
CMD php-fpm -D && nginx -g "daemon off;"
