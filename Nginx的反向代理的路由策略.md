# 字符串匹配
location /static {
  alias  /home/www/static;
  access_log off;
}
# 路径匹配，此时proxy_pass的结束 / 决定是否带上匹配的路径
location ^~ /333/ {
  proxy_pass http://106.185.48.229/;
}
# 正则匹配，此时proxy_pass不能带结束 /
location ~ ^/(xxx|yyy)/ {
  proxy_pass http://106.185.48.229;
}
# 字符串匹配，此时proxy_pass的结束 / 决定是否带上匹配得路径
location /zzz/ {
  proxy_pass http://106.185.48.229/;
}
# 默认匹配
location / {
  proxy_pass http://127.0.0.1:8080;
}
