defmodule CautiousMeme.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :hp, :integer
      add :attack, :integer
      add :defense, :integer
      add :special_attack, :integer
      add :special_defense, :integer
      add :speed, :integer

      timestamps()
    end

    create unique_index(:pokemons, [:name])
  end
end
