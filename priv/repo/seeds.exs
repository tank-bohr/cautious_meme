# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CautiousMeme.Repo.insert!(%CautiousMeme.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CautiousMeme.Repo
alias CautiousMeme.Pokemons.Pokemon

:cautious_meme
|> Application.app_dir("priv/repo/pokemons.json")
|> File.read!()
|> Jason.decode!()
|> Enum.filter(fn pokemon_attrs -> pokemon_attrs["mod"] == "" end)
|> Enum.map(fn pokemon_attrs ->
  {types, pokemon_attrs} = Map.pop(pokemon_attrs, "types")

  pokemon =
    %Pokemon{}
    |> Pokemon.changeset(pokemon_attrs)
    |> Repo.insert!()

  Enum.each(types, fn name ->
    pokemon
    |> Ecto.build_assoc(:types, %{name: name})
    |> Repo.insert!
  end)
end)
