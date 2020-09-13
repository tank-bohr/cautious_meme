defmodule CautiousMeme.Pokemons.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  alias CautiousMeme.Pokemons.Type

  schema "pokemons" do
    field :attack, :integer
    field :defense, :integer
    field :hp, :integer
    field :name, :string
    field :special_attack, :integer
    field :special_defense, :integer
    field :speed, :integer
    has_many :types, Type

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :hp, :attack, :defense, :special_attack, :special_defense, :speed])
    |> validate_required([:name, :hp, :attack, :defense, :special_attack, :special_defense, :speed])
    |> unique_constraint(:name)
  end
end
