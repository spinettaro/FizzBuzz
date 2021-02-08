defmodule Fizzbuzz.FizzbuzzContextTest do

  alias Fizzbuzz.FizzbuzzContext
  alias Fizzbuzz.Favourites

  use Fizzbuzz.DataCase, async: true

  test "Given range 1..3 will return 1,2,Fizz" do
    # ARRANGE
    from=1
    to=3
    # ACT
    result= FizzbuzzContext.fizzbuzz(from, to, [])
    # ASSERT
    expected= [{1, 1, false}, {2, 2, false}, {3, "Fizz", false}]
    assert( result ==  expected)
  end

  test "Given range 4..5 will return only 4,Buzz" do
    # ARRANGE
    from=4
    to=5
    # ACT
    result= FizzbuzzContext.fizzbuzz(from, to, [])
    # ASSERT
    expected= [{4, 4, false}, {5, "Buzz", false}]
    assert( result ==  expected)
  end

  test "Given range 10..15 will return Fizz,Buzz and FizzBuzz" do
    # ARRANGE
    from=10
    to=15
    # ACT
    result= FizzbuzzContext.fizzbuzz(from, to, [])
    # ASSERT
    expected= [{10, "Buzz", false}, {11, 11, false}, {12, "Fizz", false}, {13, 13, false}, {14, 14, false}, {15, "FizzBuzz", false}]
    assert( result ==  expected)
  end

  test "Given a range with no integers will raise an exception" do
    # ARRANGE
    from="a"
    to="b"
    # ACT and ASSERT
    assert_raise(RuntimeError, "The passed range #{from}..#{to} doesn't respect the criteria: `from` and `to` must be integers and `to` must be less than 100000000000. Favourites must be a list", fn -> FizzbuzzContext.fizzbuzz(from, to, []) end)
  end

  test "Given a range over the limit will raise an exception" do
    # ARRANGE
    from=0
    to=100000000000 + 1
    # ACT and ASSERT
    assert_raise(RuntimeError, "The passed range #{from}..#{to} doesn't respect the criteria: `from` and `to` must be integers and `to` must be less than 100000000000. Favourites must be a list", fn -> FizzbuzzContext.fizzbuzz(from, to, []) end)
  end

  test "Given page 1 size 15 will return Fizz Buzz and FizzBuzz" do
    # ARRANGE
    pagination= %{"page" => 1, "page_size" => 15}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    expected= [{1, 1, false}, {2, 2, false}, {3, "Fizz", false}, {4, 4, false}, {5, "Buzz", false}, {6, "Fizz", false}, {7, 7, false}, {8, 8, false}, {9, "Fizz", false}, {10, "Buzz", false}, {11, 11, false}, {12, "Fizz", false}, {13, 13, false}, {14, 14, false}, {15, "FizzBuzz", false}]
    assert( result["items"] ==  expected)
  end

  test "Given nil pagination return error" do
    # ARRANGE
    pagination= nil
    # ACT ASSERT
    assert_raise(RuntimeError, fn -> FizzbuzzContext.paged_fizzbuzz( pagination) end)
  end

  test "Given not map as pagination return error" do
    # ARRANGE
    pagination= []
    # ACT ASSERT
    assert_raise(RuntimeError, fn -> FizzbuzzContext.paged_fizzbuzz( pagination) end)
  end

  test "Given empty pagination will return defaults: page 1 size 100" do
    # ARRANGE
    pagination= %{}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    assert( 100 = Enum.count(result["items"]) )
  end

  test "Given page 1 size 1000 will return 1000 elements" do
    # ARRANGE
    pagination= %{"page" => 1, "page_size" => 1000}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    assert( 1000 == Enum.count( result["items"]))
  end

  test "Given page 1 size 15 will return paged result" do
    # ARRANGE
    pagination= %{"page" => 1, "page_size" => 15}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    assert( 1  == result["page"])
    assert( 15 == result["page_size"])
    assert( 6666666667 == result["total_pages"])
    assert( 100_000_000_000 == result["total_results"])
    assert( 15 == Enum.count( result["items"]))
  end

  test "Given page 1 size 15 as strings will return paged result" do
    # ARRANGE
    pagination= %{"page" => "1", "page_size" => "15"}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    assert( 1  == result["page"])
    assert( 15 == result["page_size"])
    assert( 6666666667 == result["total_pages"])
    assert( 100_000_000_000 == result["total_results"])
    assert( 15 == Enum.count( result["items"]))
  end

  test "Given page 5 size 100 will return paged result" do
    # ARRANGE
    pagination= %{"page" => 5, "page_size" => 250}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    assert( 5  == result["page"])
    assert( 250 == result["page_size"])
    assert( 400000000 == result["total_pages"])
    assert( 100_000_000_000 == result["total_results"])
    assert( 250 == Enum.count( result["items"]))
  end

  test "Given last page with size 100_003 will return paged result and less items than size" do
    # ARRANGE
    pagination= %{"page" => 999971, "page_size" => 100_003}
    # ACT
    result= FizzbuzzContext.paged_fizzbuzz( pagination)
    # ASSERT
    assert( 999971  == result["page"])
    assert( 100_003 == result["page_size"])
    assert( 999971 == result["total_pages"])
    assert( 100_000_000_000 == result["total_results"])
    assert( 90 == Enum.count( result["items"]))
  end


  test "Given number no favourite using toggle makes it as favourite" do
    # ARRANGE
    # ACT
    FizzbuzzContext.toggle_favourite( 5)
    # ASSERT
    assert( Favourites.is_favourite?(5))
  end

  test "Given number favourite using toggle makes it as no favourite" do
    # ARRANGE
    # ACT
    FizzbuzzContext.toggle_favourite( 5)
    FizzbuzzContext.toggle_favourite( 5)
    # ASSERT
    assert( not Favourites.is_favourite?(5) )
  end

  test "Given a number in list is_favourite is true" do
    # ARRANGE
    # ACT
    # ASSERT
    assert( FizzbuzzContext.is_favourite?( 5, Enum.to_list(1..10)) )
  end

  test "Given a number not in list is_favourite is false" do
    # ARRANGE
    # ACT
    # ASSERT
    assert( not FizzbuzzContext.is_favourite?( 5, Enum.to_list(8..10)) )
  end

  test "Given not a number is_favourite is false" do
    # ARRANGE
    # ACT
    # ASSERT
    assert( not FizzbuzzContext.is_favourite?( "5", Enum.to_list(1..10)) )
  end

  test "Given not a number using toggle raise exception" do
    # ARRANGE
    # ACT
    # ASSERT
    assert_raise(Ecto.Query.CastError, fn -> FizzbuzzContext.toggle_favourite( "a") end)
  end

end
