FROM registry.access.redhat.com/rhel7/rhel
MAINTAINER Javier Martinez Nohales <jmn@redhat.com>
EXPOSE 8080
RUN mkdir /docroot 
RUN ln -s /etc/hostname /docroot/index.html
RUN chmod 777 /docroot 
WORKDIR "/docroot"
CMD [ "python", "-m", "SimpleHTTPServer", "8080" ]
