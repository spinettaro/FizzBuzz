defmodule Fizzbuzz.Repo.Migrations.CreateFavourites do
  use Ecto.Migration

  def change do
    create table(:favourites) do
      add :number, :integer, null: false
      timestamps()
    end

    create unique_index( :favourites, [:number])
  end

end
