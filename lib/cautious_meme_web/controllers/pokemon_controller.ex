defmodule CautiousMemeWeb.PokemonController do
  use CautiousMemeWeb, :controller

  alias CautiousMeme.Pokemons
  alias CautiousMeme.Pokemons.Pokemon

  action_fallback CautiousMemeWeb.FallbackController

  def index(conn, _params) do
    pokemons = Pokemons.list_pokemons()
    render_if_stale(conn, "index.json", pokemons: pokemons)
  end

  def create(conn, %{"pokemon" => pokemon_params}) do
    with {:ok, %Pokemon{} = pokemon} <- Pokemons.create_pokemon(pokemon_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pokemon_path(conn, :show, pokemon))
      |> render("show.json", pokemon: pokemon)
    end
  end

  def show(conn, %{"id" => id}) do
    pokemon = Pokemons.get_pokemon!(id)
    render(conn, "show.json", pokemon: pokemon)
  end

  def update(conn, %{"id" => id, "pokemon" => pokemon_params}) do
    pokemon = Pokemons.get_pokemon!(id)

    with {:ok, %Pokemon{} = pokemon} <- Pokemons.update_pokemon(pokemon, pokemon_params) do
      render(conn, "show.json", pokemon: pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    pokemon = Pokemons.get_pokemon!(id)

    with {:ok, %Pokemon{}} <- Pokemons.delete_pokemon(pokemon) do
      send_resp(conn, :no_content, "")
    end
  end
end
