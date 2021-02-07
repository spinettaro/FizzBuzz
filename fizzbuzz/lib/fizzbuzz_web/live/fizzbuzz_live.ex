defmodule FizzbuzzWeb.FizzbuzzLive do
  use FizzbuzzWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
