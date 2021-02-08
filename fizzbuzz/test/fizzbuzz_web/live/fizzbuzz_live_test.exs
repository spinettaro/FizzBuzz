defmodule FizzbuzzWeb.FizzbuzzLiveTest do
  use FizzbuzzWeb.ConnCase

  import Phoenix.LiveViewTest

  test "fizzbuzz default page", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    assert render(view) =~ "<h1>FizzBuzz Page</h1>"
  end

  test "fizzbuzz default values in page", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    content = render(view)
    "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz Fizz 22 23 Fizz Buzz 26 Fizz 28 29 FizzBuzz 31 32 Fizz 34 Buzz Fizz 37 38 Fizz Buzz 41 Fizz 43 44 FizzBuzz 46 47 Fizz 49 Buzz Fizz 52 53 Fizz Buzz 56 Fizz 58 59 FizzBuzz 61 62 Fizz 64 Buzz Fizz 67 68 Fizz Buzz 71 Fizz 73 74 FizzBuzz 76 77 Fizz 79 Buzz Fizz 82 83 Fizz Buzz 86 Fizz 88 89 FizzBuzz 91 92 Fizz 94 Buzz Fizz 97 98 Fizz Buzz"
    |> String.split(" ")
    |> Enum.each(fn str -> assert String.contains?(content, str)  end)
  end

  test "fizzbuzz select page size 250", %{conn: conn} do
    change= %{"pagination" => %{"page_size" => 250}}
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    content= view |> element("form") |> render_change(change)

    assert content =~ "1"
    assert content =~ "248"
  end

  test "fizzbuzz click next page ", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    content= view |> element("#go_to_next") |> render_click()
    assert content =~ "101"
  end

  test "fizzbuzz click prev page remain on page 1 ", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    content= view |> element("#go_to_prev") |> render_click()
    assert content =~ "1"
  end

  test "fizzbuzz click page 5 ", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    assert not (render(view) =~ "401")
    content= view |> element("#go_to_5") |> render_click()
    assert content =~ "401"
  end

  test "fizzbuzz mark as favourite ", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")

    assert render_click(view, String.to_atom("add-favourite"), %{"num" => 1}) =~ "fa fa-star"

  end

  test "fizzbuzz toggle favourite ", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/fizzbuzz")
    assert render_click(view, String.to_atom("delete-favourite"), %{"num" => 1}) =~ "fa fa-star-o"
  end

end
