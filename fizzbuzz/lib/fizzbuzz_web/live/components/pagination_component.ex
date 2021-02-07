defmodule FizzbuzzWeb.PaginationComponent do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_component
  use Phoenix.LiveComponent
  use Phoenix.HTML

  @defaults %{min_left_page: 1, min_right_page: 7, page_boundaries: 3}

  @impl true
  def mount( socket) do
    {:ok, socket}
  end

  @impl true
  def update( assigns, socket) do
    assigns= Map.merge(assigns, @defaults)
    {:ok, assign( socket, assigns)}
  end

  @impl true
  def render( assigns) do
    ~L"""
    <div class="pagination">
      <a id="go_to_prev" href="#" phx-click="goto-page" phx-value-page=<%= @paged_fizzbuzz["page"] - 1 %>>Previous</a>

      <%= for page <- ( max(@min_left_page, @paged_fizzbuzz["page"]-@page_boundaries)..max(@min_right_page, @paged_fizzbuzz["page"]+@page_boundaries)) do %>
        <a id="go_to_<%=page%>" class='<%= if(page == @paged_fizzbuzz["page"]) do "active" end %>' href="#" phx-click="goto-page" phx-value-page=<%= page %>><%= page %></a>
      <% end %>

      <a id="go_to_next" href="#" phx-click="goto-page" phx-value-page=<%= @paged_fizzbuzz["page"] + 1 %>>Next</a>
    </div>
    """
  end

end
