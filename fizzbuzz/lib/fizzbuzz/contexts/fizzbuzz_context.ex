defmodule Fizzbuzz.FizzbuzzContext do

  @fizz     "Fizz"
  @buzz     "Buzz"
  @fizzbuzz @fizz<>@buzz

  @fizz_divisor 3
  @buzz_divisor 5

  @to_limit 100_000_000_000

  def fizzbuzz(from, to) when is_integer(from) and is_integer(from) and to <= @to_limit do
    Enum.map(from..to, fn number ->
      fizz = rem(number, @fizz_divisor) == 0
      buzz = rem(number, @buzz_divisor) == 0
      cond do
        fizz and buzz -> @fizzbuzz
        fizz          -> @fizz
        buzz          -> @buzz
        true          -> number
      end
    end)
  end

  def fizzbuzz(from, to) do
    raise "The passed range #{from}..#{to} doesn't respect the criteria: `from` and `to` must be integers and `to` must be less than #{@to_limit}"
  end

end
