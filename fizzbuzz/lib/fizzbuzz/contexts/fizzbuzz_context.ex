defmodule Fizzbuzz.FizzbuzzContext do

  alias Fizzbuzz.Favourites

  @fizz     "Fizz"
  @buzz     "Buzz"
  @fizzbuzz @fizz<>@buzz

  @fizz_divisor 3
  @buzz_divisor 5

  @to_limit 100_000_000_000

  @default_page 1
  @default_page_size 100

  @default_params %{"page" => @default_page, "page_size" => @default_page_size}

  def toggle_favourite( number) do

    case Favourites.is_favourite?( number) do
      true  -> Favourites.delete_favourite( number)
      false -> Favourites.add_favourite( number)
    end

  end

  def is_favourite?( number, favourites) when is_number( number) do
    number in favourites
  end

  def is_favourite?(_number, _favourites) do
    false
  end

  def paged_fizzbuzz( params) when (not is_map( params)) do
    raise "The passed params doesn't respect the criteria: you must insert a page and a size -> %{\"page\" => page, \"page_size\" => page_size}"
  end

  def paged_fizzbuzz( params) do
    %{"page" => page, "page_size" => size}= scan_params( params)
    from= max(1, ( (page - 1) * size) + 1)
    to= min(@to_limit, from - 1 + size)
    items= fizzbuzz(from, to, Favourites.get_favourites( from, to) )
    %{
      "page"          => max(1, page),
      "page_size"     => size,
      "total_pages"   => ceil(@to_limit / size),
      "total_results" => @to_limit,
      "items"         => items
    }
  end


  def fizzbuzz(from, to, favourites) when is_integer(from) and is_integer(from) and to <= @to_limit and is_list( favourites) do
    Enum.map(from..to, fn number -> [number, fizzbuzz( number), is_favourite?( number, favourites) ] end)
  end

  def fizzbuzz(from, to, _favourites) do
    raise "The passed range #{from}..#{to} doesn't respect the criteria: `from` and `to` must be integers and `to` must be less than #{@to_limit}. Favourites must be a list"
  end

  defp fizzbuzz( number) when is_integer(number) do
    fizz = rem(number, @fizz_divisor) == 0
    buzz = rem(number, @buzz_divisor) == 0
    cond do
        fizz and buzz -> @fizzbuzz
        fizz          -> @fizz
        buzz          -> @buzz
        true          -> number
    end
  end

  defp scan_params( params) do
    Map.merge(@default_params, params)
    |> Map.update( "page", @default_page, fn el -> if is_bitstring( el), do: String.to_integer( el), else: el end)
    |> Map.update( "page_size", @default_page_size, fn el -> if is_bitstring( el), do: String.to_integer( el), else: el end)
  end

end
