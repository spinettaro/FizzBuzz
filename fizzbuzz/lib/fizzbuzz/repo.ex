defmodule Fizzbuzz.Repo do
  use Ecto.Repo,
    otp_app: :fizzbuzz,
    adapter: Ecto.Adapters.Postgres
end
