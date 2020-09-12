defmodule CautiousMeme.Pokemons.Type do
  use Ecto.Schema
  import Ecto.Changeset

  alias CautiousMeme.Pokemons.Pokemon

  schema "pokemon_types" do
    field :name, :string
    belongs_to :pokemon, Pokemon

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
