defmodule FizzbuzzWeb.FizzbuzzControllerTest do
  use FizzbuzzWeb.ConnCase, async: true

  test "fizzbuzz default values with no params", %{conn: conn} do
    # ARRANGE
    # ACT
    conn = conn |> get("/api/fizzbuzz")
    # ASSERT
    assert 200 == conn.status
    result= Jason.decode!( conn.resp_body)
    assert( 1  == result["page"])
    assert( 100 == result["page_size"])
    assert( 1000000000 == result["total_pages"])
    assert( 100_000_000_000 == result["total_results"])
    assert( 100 == Enum.count( result["items"]))
  end

  test "fizzbuzz sending page 1 and page_size 15", %{conn: conn} do
    # ARRANGE
    # ACT
    conn = conn |> get("/api/fizzbuzz?page=1&page_size=15")
    # ASSERT
    assert 200 == conn.status
    result= Jason.decode!( conn.resp_body)
    assert( 1  == result["page"])
    assert( 15 == result["page_size"])
    assert( 6666666667 == result["total_pages"])
    assert( 100_000_000_000 == result["total_results"])
    assert( 15 == Enum.count( result["items"]))
  end

  test "fizzbuzz mark 1 as favourite", %{conn: conn} do
    # ARRANGE
    # ACT
    conn = conn |> put("/api/favourites", number: 1, is_favourite: true)
    # ASSERT
    assert 200 == conn.status
    result= Jason.decode!( conn.resp_body)
    assert( [1,true] == result["result"])
  end

  test "fizzbuzz mark 1 to favourite true and then false", %{conn: conn} do
    # ARRANGE
    # ACT
    conn = conn |> put("/api/favourites", number: 1, is_favourite: true) |> put("/api/favourites", number: 1, is_favourite: false)
    # ASSERT
    assert 200 == conn.status
    assert 200 == conn.status
    result= Jason.decode!( conn.resp_body)
    assert( [1,false] == result["result"])
  end

end
