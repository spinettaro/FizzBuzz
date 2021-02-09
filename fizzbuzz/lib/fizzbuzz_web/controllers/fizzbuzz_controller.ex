defmodule FizzbuzzWeb.Api.FizzbuzzController do

  use FizzbuzzWeb, :controller

  alias Fizzbuzz.FizzbuzzContext

  def get_fizzbuzz( conn, params) do
    json conn, FizzbuzzContext.paged_fizzbuzz( params)
  end

  def mark_favourite( conn, %{"number" => number, "is_favourite" => is_favourite}) do
    FizzbuzzContext.mark_favourite( number, is_favourite)
    json conn, :ok
  end

end
