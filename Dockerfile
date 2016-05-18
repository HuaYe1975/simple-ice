From romeohua/simple-php7:nodebug

ENV BASEDIR /

RUN yum -y update && yum install -y git sudo && yum clean all

# Edit sudoers file
# To avoid error: sudo: sorry, you must have a tty to run sudo
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers

WORKDIR ${BASEDIR}

RUN git clone --depth=1 https://github.com/ice/framework.git

WORKDIR /framework
RUN export PATH=$PATH:/usr/local/php/bin && ./install

RUN echo "extension=/framework/build/php7/modules/ice.so" > /usr/local/php/etc/php.d/ice.ini

RUN supervisorctl restart nginx

RUN supervisorctl restart php-fpm