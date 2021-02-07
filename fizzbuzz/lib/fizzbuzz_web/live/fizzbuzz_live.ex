defmodule FizzbuzzWeb.FizzbuzzLive do
  use FizzbuzzWeb, :live_view

  alias Fizzbuzz.FizzbuzzContext

  @page_sizes [50, 100, 250]

  @impl true
  def mount(params, _session, socket) do
    {:ok, assign( socket, page_sizes: @page_sizes) |> load_data( params) }
  end

  @impl true
  def handle_event("on_size_change",  %{"pagination" => pagination }, socket) do
    {:noreply, load_data(socket, pagination) }
  end

  defp load_data(socket, params) do
    assign( socket, paged_fizzbuzz: FizzbuzzContext.paged_fizzbuzz(params))
  end


end
