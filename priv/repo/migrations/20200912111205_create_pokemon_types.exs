defmodule CautiousMeme.Repo.Migrations.CreatePokemonTypes do
  use Ecto.Migration

  def change do
    create table(:pokemon_types) do
      add :name, :string
      add :pokemon_id, references(:pokemons, on_delete: :delete_all)

      timestamps()
    end

    create index(:pokemon_types, [:pokemon_id, :name])
  end
end
