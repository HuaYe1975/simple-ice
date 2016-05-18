From romeohua/simple-php7:nodebug

ENV BASEDIR /

RUN yum -y update && yum install -y git && yum clean all

WORKDIR ${BASEDIR}

RUN git clone --depth=1 https://github.com/ice/framework.git

WORKDIR /framework
RUN export PATH=$PATH:/usr/local/php/bin && ./install

RUN echo "extension=/framework/build/php7/modules/ice.so" > /usr/local/php/etc/php.d/ice.ini

RUN supervisorctl restart nginx

RUN supervisorctl restart php-fpm