defmodule Outer do
  defmodule Inner do
    def inner_fn do
      IO.puts "Hello There (inner)"
    end

    def inner_fn(a) do
      IO.puts "Hello There (inner) => " <> a
    end
  end

  def outer_fn do
    Inner.inner_fn
    IO.puts "Hello There (outer)"
    Inner.inner_fn("From outer")
  end
end

Outer.outer_fn
Outer.Inner.inner_fn
