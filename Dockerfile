FROM registry.access.redhat.com/rhel7/rhel
USER root
MAINTAINER Juan Luis Buenosvinos <jbuenosv@redhat.com>

#EXPOSE 8888
#RUN mkdir /docroot 
#RUN ln -s /etc/hostname /docroot/index.html
#RUN chmod 777 /docroot 
#WORKDIR "/docroot"
#CMD [ "python", "-m", "SimpleHTTPServer", "8888" ]

# Fix per https://bugzilla.redhat.com/show_bug.cgi?id=1192200 
RUN yum -y install deltarpm yum-utils --disablerepo=*-eus-* --disablerepo=*-htb-* \
    --disablerepo=*-ha-* --disablerepo=*-rt-* --disablerepo=*-lb-* --disablerepo=*-rs-* --disablerepo=*-sap-*

RUN yum-config-manager --disable *-eus-* *-htb-* *-ha-* *-rt-* *-lb-* *-rs-* *-sap-* > /dev/null

# Update image
RUN yum update -y
#RUN yum install httpd procps-ng MySQL-python -y
RUN yum install httpd procps-ng -y

# Add configuration file
ADD action /var/www/cgi-bin/action
RUN chown root:apache /var/www/cgi-bin/action
RUN chmod 755 /var/www/cgi-bin/action
RUN echo "The Web Server is Running at:\n" > /var/www/html/index.html
RUN ln -s /etc/hostname >> /var/www/html/index.html
EXPOSE 8888

# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
