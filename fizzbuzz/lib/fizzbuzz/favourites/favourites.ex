defmodule Fizzbuzz.Favourites do

  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Fizzbuzz.Repo

  schema "favourites" do
    field :number, :integer
    timestamps()
  end

  def changeset( favourite, attrs) do
    favourite
    |> cast( attrs, [:number])
  end

  def add_favourite( number) do
    %Fizzbuzz.Favourites{}
    |> changeset(%{number: number})
    |> Repo.insert( on_conflict: :nothing, conflict_target: [:number], returning: [:number])
    :added
  end

  def is_favourite?( number) do
    from( f in Fizzbuzz.Favourites, where: f.number == ^number )
    |> Repo.exists?()
  end

  def delete_favourite( number) do
    from(f in Fizzbuzz.Favourites, where: f.number == ^number )
    |> Repo.delete_all()
    :deleted
  end

  def get_favourites( from, to) do
    range= Enum.to_list(from..to )
    from(f in Fizzbuzz.Favourites, where: f.number in (^range) )
    |> Repo.all()
    |> Enum.map( fn f -> f.number end)
  end


end
