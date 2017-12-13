FROM registry.access.redhat.com/rhel7/rhel
MAINTAINER Juan Luis Buenosvinos <jbuenosv@redhat.com>

#EXPOSE 8888
#RUN mkdir /docroot 
#RUN ln -s /etc/hostname /docroot/index.html
#RUN chmod 777 /docroot 
#WORKDIR "/docroot"
#CMD [ "python", "-m", "SimpleHTTPServer", "8888" ]

# Add configuration file
RUN echo "The Web Server is Running at:\n" > /var/www/html/index.html
RUN ln -s /etc/hostname >> /var/www/html/index.html
EXPOSE 8888

# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
