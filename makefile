up:
	docker-compose up -d

buildup:
	docker-compose up -d --build

down:
	docker-compose down

test:
	docker-compose exec nginx /usr/sbin/nginx -t

reload:
	docker-compose exec nginx /usr/sbin/nginx -s reload

log:
	docker-compose logs nginx

sh:
	docker-compose exec nginx sh

ps:
	docker-compose ps

redis:
	docker-compose exec redis redis-cli