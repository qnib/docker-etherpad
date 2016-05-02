FROM qnib/syslog

RUN dnf install -y gzip git curl python openssl-devel \
 && yum groupinstall -y "Development Tools" \
 && git clone git://github.com/ether/etherpad-lite.git /opt/etherpad/
RUN dnf install -y npm nodejs
RUN cd /opt/etherpad/ \
 && npm install ep_colors \
 && npm install ep_copy_paste_images \
 && npm install ep_draw \
 && npm install ep_embedmedia \
 && npm install ep_ether-o-meter \
 && npm install ep_fileupload \
 && npm install ep_markdown \
 && npm install ep_markdownify \
 && npm install ep_tasklist 
RUN cd /opt/etherpad/ \
 && ./bin/installDeps.sh
RUN dnf install -y passwd \
 && useradd -m etherpad \
 && echo $(date +%s | sha256sum | base64 | head -c 32 ; echo) | passwd --stdin etherpad \
 && chown -R etherpad: /opt/etherpad/
ADD etc/consul-templates/etherpad/settings.json.ctmpl /etc/consul-templates/etherpad/
ADD opt/qnib/etherpad/bin/start.sh /opt/qnib/etherpad/bin/
ADD etc/supervisord.d/etherpad.ini /etc/supervisord.d/
