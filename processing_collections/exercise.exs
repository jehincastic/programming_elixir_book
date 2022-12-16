defmodule MyList do
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]
end

for x <- MyList.span(2, 100), rem(x, 2) == 0, do: IO.puts x
