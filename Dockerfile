# Trinity Insurance landing — sitio estático servido por nginx.
# EasyPanel construye esta imagen y Traefik enruta el dominio + SSL automático.
FROM nginx:alpine
COPY . /usr/share/nginx/html
# Cache largo para assets (frames/scenes); el HTML siempre fresco.
RUN printf 'server {\n  listen 80;\n  root /usr/share/nginx/html;\n  index index.html;\n  location ~* \\.(jpg|jpeg|png|css|js|woff2?)$ { expires 30d; add_header Cache-Control "public, immutable"; }\n  location / { try_files $uri $uri/ /index.html; }\n}\n' > /etc/nginx/conf.d/default.conf
EXPOSE 80
