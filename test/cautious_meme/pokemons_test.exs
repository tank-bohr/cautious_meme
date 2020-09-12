defmodule CautiousMeme.PokemonsTest do
  use CautiousMeme.DataCase

  alias CautiousMeme.Pokemons

  describe "pokemons" do
    alias CautiousMeme.Pokemons.Pokemon

    @valid_attrs %{attack: 42, defense: 42, hp: 42, name: "some name", special_attack: 42, special_defense: 42, speed: 42}
    @update_attrs %{attack: 43, defense: 43, hp: 43, name: "some updated name", special_attack: 43, special_defense: 43, speed: 43}
    @invalid_attrs %{attack: nil, defense: nil, hp: nil, name: nil, special_attack: nil, special_defense: nil, speed: nil}

    def pokemon_fixture(attrs \\ %{}) do
      {:ok, pokemon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pokemons.create_pokemon()

      pokemon
    end

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert Pokemons.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Pokemons.get_pokemon!(pokemon.id) == pokemon
    end

    test "create_pokemon/1 with valid data creates a pokemon" do
      assert {:ok, %Pokemon{} = pokemon} = Pokemons.create_pokemon(@valid_attrs)
      assert pokemon.attack == 42
      assert pokemon.defense == 42
      assert pokemon.hp == 42
      assert pokemon.name == "some name"
      assert pokemon.special_attack == 42
      assert pokemon.special_defense == 42
      assert pokemon.speed == 42
    end

    test "create_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pokemons.create_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{} = pokemon} = Pokemons.update_pokemon(pokemon, @update_attrs)
      assert pokemon.attack == 43
      assert pokemon.defense == 43
      assert pokemon.hp == 43
      assert pokemon.name == "some updated name"
      assert pokemon.special_attack == 43
      assert pokemon.special_defense == 43
      assert pokemon.speed == 43
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = Pokemons.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == Pokemons.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = Pokemons.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> Pokemons.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = Pokemons.change_pokemon(pokemon)
    end
  end
end
