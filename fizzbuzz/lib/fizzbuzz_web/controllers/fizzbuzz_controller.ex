defmodule FizzbuzzWeb.Api.FizzbuzzController do

  use FizzbuzzWeb, :controller

  alias Fizzbuzz.FizzbuzzContext

  def get_fizzbuzz( conn, params) do
    json conn, FizzbuzzContext.paged_fizzbuzz( params)
  end

end
