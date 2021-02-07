defmodule Fizzbuzz.FizzbuzzContext do

  @fizz     "Fizz"
  @buzz     "Buzz"
  @fizzbuzz @fizz<>@buzz

  @fizz_divisor 3
  @buzz_divisor 5

  @to_limit 100_000_000_000

  @default_params %{"page" => 1, "page_size" => 100}

  def paged_fizzbuzz( params) when (not is_map( params)) do
    raise "The passed params doesn't respect the criteria: you must insert a page and a size -> %{\"page\" => page, \"page_size\" => page_size}"
  end

  def paged_fizzbuzz( params) do
    %{"page" => page, "page_size" => size}= scan_params( params)
    from= max(1, ( (page - 1) * size) + 1)
    to= min(@to_limit, from - 1 + size)
    items= fizzbuzz(from, to)
    %{
      "page"          => page,
      "page_size"     => size,
      "total_pages"   => ceil(@to_limit / size),
      "total_results" => @to_limit,
      "items"         => items
    }
  end


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

  defp scan_params( params) do
    Map.merge(@default_params, params)
    |> Map.update( "page", 1, fn el -> if is_bitstring( el), do: String.to_integer( el), else: el end)
    |> Map.update( "page_size", 1000, fn el -> if is_bitstring( el), do: String.to_integer( el), else: el end)
  end

end
