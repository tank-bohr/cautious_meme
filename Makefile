.PHONY: server
server:
	iex -S mix phx.server

.PHONY: sql
sql:
	docker-compose run db mysql -u root cautious_meme_dev -h db

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
