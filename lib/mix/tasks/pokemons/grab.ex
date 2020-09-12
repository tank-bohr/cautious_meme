defmodule Mix.Tasks.Pokemons.Grab do
  use Mix.Task

  @shortdoc "Download and parses pokemons"

  def run(_args) do
    Mix.Task.run("app.start")
    "https://pokemondb.net/pokedex/all"
    |> HTTPoison.get!()
    |> Map.fetch!(:body)
    |> Floki.parse_document!()
    |> Floki.find("table#pokedex tbody")
    |> List.first()
    |> Floki.children()
    |> Enum.map(fn row ->
      name = row
        |> Floki.find("td.cell-name a.ent-name")
        |> Floki.text()

      types = row
        |> Floki.find("td.cell-icon a.type-icon")
        |> Enum.map(fn elem ->
          elem
          |> Floki.attribute("class")
          |> List.first()
          |> String.split()
          |> Enum.find(fn class_name -> class_name != "type-icon" end)
          |> String.trim_leading("type-")
        end)

      [_, hp, attack, defense, special_attack, special_defense, speed] =
        row
        |> Floki.find("td.cell-num")
        |> Enum.map(&Floki.text/1)
        %{
          name: name,
          types: types,
          hp: hp,
          attack: attack,
          defense: defense,
          special_attack: special_attack,
          special_defense: special_defense,
          speed: speed,
        }
    end)
    |> Jason.encode!()
    |> IO.puts()
  end
end
