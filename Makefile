.PHONY: server
server:
	iex -S mix phx.server

.PHONY: sql
sql:
	docker-compose run db mysql -u root cautious_meme_dev -h db

###############
### Maxwell ###
###############

.PHONY: setup_maxwell
setup_maxwell:
	docker-compose run db mysql -u root -h db -e "\
		CREATE USER 'maxwell'@'%' IDENTIFIED BY 'maxwell';\
		GRANT ALL ON maxwell.* TO 'maxwell'@'%';\
		GRANT SELECT, REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO 'maxwell'@'%';\
	"

################
### Debezium ###
################

.PHONY: watch
watch:
	docker-compose run --rm -e "KAFKA_BROKER=kafka:9092" kafka watch-topic -a -k dbserver1.cautious_meme_dev.pokemons

.PHONY: register_connector
register_connector: connector.json
	curl -i \
		-H "Accept: application/json" \
		-H "Content-Type: application/json" \
		-d @connector.json \
		http://localhost:8083/connectors/

.PHONY: check_connector
check_connector:
	curl -s -H "Accept: application/json" http://localhost:8083/connectors/ | jq .

.PHONY: review_connector
review_connector:
	curl -s -H "Accept: application/json" http://localhost:8083/connectors/pokemons-connector | jq .

# See https://github.com/shyiko/mysql-binlog-connector-java/issues/240#issuecomment-494434539
.PHONY: fix_password_error
fix_password_error:
	docker-compose run db mysql -u root -h db -e "ALTER USER root IDENTIFIED WITH mysql_native_password BY ''"

#################
### Bootstrap ###
#################

CONTROLLER=lib/cautious_meme_web/controllers/pokemon_controller.ex
POKEMON_TYPE_SCHEMA=lib/cautious_meme/pokemons/type.ex
POKEMONS_DATA=priv/repo/pokemons.json

.PHONY: bootstrap
bootstrap: $(CONTROLLER) $(POKEMON_TYPE_SCHEMA) $(POKEMONS_DATA)

$(CONTROLLER):
	mix phx.gen.json \
		Pokemons Pokemon pokemons \
		name:string:unique \
		hp:integer \
		attack:integer \
		defense:integer \
		special_attack:integer \
		special_defense:integer \
		speed:integer

$(POKEMON_TYPE_SCHEMA):
	mix phx.gen.schema Pokemons.Type pokemon_types \
		pokemon_id:references:pokemons \
		name:string

$(POKEMONS_DATA):
	mix pokemons.grab > $(POKEMONS_DATA)
