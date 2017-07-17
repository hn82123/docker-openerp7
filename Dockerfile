FROM ubuntu:xenial
# Use PostgreSQL user "openerp"

# Install "openerp.deb"
RUN echo deb http://nightly.odoo.com/10.0/nightly/deb/ ./ \
    > /etc/apt/sources.list.d/odoo-10.list 
ENV DEBIAN_FRONTEND noninteractive 
ENV LANG en_US.UTF-8 
RUN sed -i 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list 
RUN apt-get update 
RUN apt-get install -y --allow-unauthenticated odoo
RUN apt-get install -y git 

ENV ADDON /usr/lib/python2.7/dist-packages/odoo/addons
WORKDIR /tmp
RUN git clone https://github.com/shine-it/oecn_base_fonts.git
RUN cp -a oecn_base_fonts/oecn_base_fonts $ADDON
RUN apt-get install -y fonts-wqy-zenhei
# Expose HTTP port
EXPOSE 8069

COPY openerp-server.conf /odoo.conf
COPY entrypoint.sh /entrypoint.sh
RUN chown odoo /odoo.conf /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

