defmodule Fizzbuzz.FizzbuzzContextTest do
  alias Fizzbuzz.FizzbuzzContext

  use ExUnit.Case

  test "Given range 1..3 will return 1,2,Fizz" do
    # ARRANGE
    from=1
    to=3
    # ACT
    result= FizzbuzzContext.fizzbuzz(from, to)
    # ASSERT
    expected= [1, 2, "Fizz"]
    assert( result ==  expected)
  end

  test "Given range 4..5 will return only 4,Buzz" do
    # ARRANGE
    from=4
    to=5
    # ACT
    result= FizzbuzzContext.fizzbuzz(from, to)
    # ASSERT
    expected= [4, "Buzz"]
    assert( result ==  expected)
  end

  test "Given range 10..15 will return Fizz,Buzz and FizzBuzz" do
    # ARRANGE
    from=10
    to=15
    # ACT
    result= FizzbuzzContext.fizzbuzz(from, to)
    # ASSERT
    expected= ["Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
    assert( result ==  expected)
  end

  test "Given a range with no integers will raise an exception" do
    # ARRANGE
    from="a"
    to="b"
    # ACT and ASSERT
    assert_raise(RuntimeError, "The passed range #{from}..#{to} doesn't respect the criteria: `from` and `to` must be integers and `to` must be less than 100000000000", fn -> FizzbuzzContext.fizzbuzz(from, to) end)
  end

  test "Given a range over the limit will raise an exception" do
    # ARRANGE
    from=0
    to=100000000000 + 1
    # ACT and ASSERT
    assert_raise(RuntimeError, "The passed range #{from}..#{to} doesn't respect the criteria: `from` and `to` must be integers and `to` must be less than 100000000000", fn -> FizzbuzzContext.fizzbuzz(from, to) end)
  end

end
