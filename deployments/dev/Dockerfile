# 这里是别人已经搭建好的的一个pupptr运行环境
# https://hub.docker.com/r/buildkite/puppeteer/dockerfile
FROM buildkite/puppeteer

# 复制配置文件
## 防止中文乱码
ADD simsun.ttc /usr/share/fonts
ADD start.sh /start.sh
RUN chmod 755 /start.sh

VOLUME /var/www/html
WORKDIR /var/www/html

# npm换源
RUN npm config set registry https://registry.npm.taobao.org

EXPOSE 31040

CMD ["/start.sh"]
