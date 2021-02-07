defmodule FizzbuzzWeb.FizzbuzzLive do
  use FizzbuzzWeb, :live_view

  alias Fizzbuzz.FizzbuzzContext

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign( socket, items: FizzbuzzContext.fizzbuzz(1, 100)) }
  end

end
