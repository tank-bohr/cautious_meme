defmodule CautiousMemeWeb.PokemonView do
  use CautiousMemeWeb, :view
  alias CautiousMemeWeb.PokemonView

  def render("index.json", %{pokemons: pokemons}) do
    %{data: render_many(pokemons, PokemonView, "pokemon.json")}
  end

  def render("show.json", %{pokemon: pokemon}) do
    %{data: render_one(pokemon, PokemonView, "pokemon.json")}
  end

  def render("pokemon.json", %{pokemon: pokemon}) do
    %{id: pokemon.id,
      name: pokemon.name,
      hp: pokemon.hp,
      attack: pokemon.attack,
      defense: pokemon.defense,
      special_attack: pokemon.special_attack,
      special_defense: pokemon.special_defense,
      speed: pokemon.speed}
  end

  def stale_checks("index.json", %{pokemons: data}) do
    [etag: schema_etag(data),
     last_modified: schema_last_modified(data)]
  end
end
