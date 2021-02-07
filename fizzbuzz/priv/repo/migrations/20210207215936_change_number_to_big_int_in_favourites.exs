defmodule Fizzbuzz.Repo.Migrations.ChangeNumberToBigIntInFavourites do
  use Ecto.Migration

  def change do
    alter table(:favourites) do
      modify :number, :bigint
    end
  end
end
