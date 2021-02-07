defmodule FizzbuzzWeb.PageLiveTest do
  use FizzbuzzWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to FizzBuzz!"
    assert render(page_live) =~ "Welcome to FizzBuzz!"
  end

  test "click on let's start", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    render_click(view, :start)
    assert_redirected view, "/fizzbuzz"
  end

end
