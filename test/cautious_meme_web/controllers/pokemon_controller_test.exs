defmodule CautiousMemeWeb.PokemonControllerTest do
  use CautiousMemeWeb.ConnCase

  alias CautiousMeme.Pokemons
  alias CautiousMeme.Pokemons.Pokemon

  @create_attrs %{
    attack: 42,
    defense: 42,
    hp: 42,
    name: "some name",
    special_attack: 42,
    special_defense: 42,
    speed: 42,
    total: 42
  }
  @update_attrs %{
    attack: 43,
    defense: 43,
    hp: 43,
    name: "some updated name",
    special_attack: 43,
    special_defense: 43,
    speed: 43,
    total: 43
  }
  @invalid_attrs %{attack: nil, defense: nil, hp: nil, name: nil, special_attack: nil, special_defense: nil, speed: nil, total: nil}

  def fixture(:pokemon) do
    {:ok, pokemon} = Pokemons.create_pokemon(@create_attrs)
    pokemon
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pokemons", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pokemon" do
    test "renders pokemon when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => id,
               "attack" => 42,
               "defense" => 42,
               "hp" => 42,
               "name" => "some name",
               "special_attack" => 42,
               "special_defense" => 42,
               "speed" => 42,
               "total" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pokemon" do
    setup [:create_pokemon]

    test "renders pokemon when data is valid", %{conn: conn, pokemon: %Pokemon{id: id} = pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => id,
               "attack" => 43,
               "defense" => 43,
               "hp" => 43,
               "name" => "some updated name",
               "special_attack" => 43,
               "special_defense" => 43,
               "speed" => 43,
               "total" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pokemon: pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pokemon" do
    setup [:create_pokemon]

    test "deletes chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = delete(conn, Routes.pokemon_path(conn, :delete, pokemon))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pokemon_path(conn, :show, pokemon))
      end
    end
  end

  defp create_pokemon(_) do
    pokemon = fixture(:pokemon)
    %{pokemon: pokemon}
  end
end
