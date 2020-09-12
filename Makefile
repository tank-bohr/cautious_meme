.PHONY: server
server:
	iex -S mix phx.server

.PHONY: sql
sql:
	docker-compose run db mysql -u root cautious_meme_dev -h db
