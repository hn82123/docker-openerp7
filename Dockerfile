FROM ubuntu:trusty

# Install "openerp.deb"
# Create PostgreSQL user "openerp"
# Untar configuration "/etc/supervisor/conf.d/openerp.conf"
RUN echo deb http://nightly.odoo.com/7.0/nightly/deb/ ./ \
    > /etc/apt/sources.list.d/openerp-70.list 
ENV DEBIAN_FRONTEND noninteractive 
ENV LANG en_US.UTF-8 
RUN apt-get update 
RUN apt-get install -y --allow-unauthenticated openerp 
#RUN mkdir ~openerp && chown openerp:openerp ~openerp 
# && service postgresql start && su - postgres -c "createuser -d openerp" \
# && echo H4sIACx6i1MCA+3SwUrDQBAG4JzzFHkA66ZN2oLQg4eiB7WgeBIpMZnWQLMTZnfz/E5j \
# Ipi7YOH/Lsv8P1kysNySJWmvS7aH6I+kapXn/ammZ5pnaTRfZPlitc7Xy2WUztNM6yS6JNPlLsRb \
# K3yUornh74fwHpfcNIWtkk1ighPzUVszdDNH0pEkszIx5MsxntT9U4qDDnrFUMVku1rYNmS9pq8v \
# 2+fNUF097O6ebh+3P/P9TgfzyQ2NF8dF8Ox8IedvvQTqA6FfkVBVC5V+73xFImOsEwe/P/HxUJ/o \
# vFRXiNHRuNDq/9aOZbqAtnEEAAAAAAAAAAAAAAAAAAAAAADwz30BmbMKRgAoAAA=             \
#  | base64 -di | tar xz -C /etc/supervisor/conf.d

# Declare volumes for data
#VOLUME ["/var/lib/openerp", "/var/lib/postgresql"]
#VOLUME ["entrypoint.sh", "/entrypoint.sh"]

# Expose HTTP port
EXPOSE 8069

COPY openerp-server.conf /openerp-server.conf
COPY entrypoint.sh /entrypoint.sh
RUN chown openerp /openerp-server.conf /entrypoint.sh
USER openerp
ENTRYPOINT ["/entrypoint.sh"]
CMD ["openerp-server", "-c", "/openerp-server.conf"]


