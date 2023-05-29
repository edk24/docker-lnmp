.PHONY: up build-up down nginx-sh nginx-reload nginx-test logs php-sh php-reload ssl-apply ssl-renew

up:
	docker compose up -d

build-up:
	docker compose up -d --build

down:
	docker compose down

nginx-sh:
	docker compose exec nginx sh

nginx-reload:
	docker compose exec nginx /usr/sbin/nginx -s reload

nginx-test:
	docker compose exec nginx /usr/sbin/nginx -t

logs:
	docker compose logs nginx

php-sh:
	docker compose exec php sh

php-reload:
	docker compose exec php kill -USR2 $(cat /run/php-fpm.pid)

ssl-apply:
	docker compose exec nginx certbot --nginx -m "yuxiaobo64@gmail.com" --agree-tos --no-eff-email -d t3.io.edk24.com

ssl-renew:
	docker compose exec nginx certbot renew