FROM treehouses/nginx:1.18

RUN apk --no-cache upgrade
RUN apk add --no-cache curl git

WORKDIR /var/lib/nginx

RUN rm -rf html
RUN git clone --depth=1 https://github.com/sugarlabs/musicblocks.git 
RUN mv -f musicblocks html

EXPOSE 80 443 3000

CMD ["nginx", "-g", "daemon off;"]
