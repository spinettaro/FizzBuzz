defmodule FizzbuzzWeb.PageLive do
  use FizzbuzzWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("start", _params, socket) do
    {:noreply, redirect(socket, to: "/fizzbuzz")}
  end
end
