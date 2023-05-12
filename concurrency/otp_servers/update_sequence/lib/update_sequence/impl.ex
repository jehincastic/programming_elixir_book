defmodule UpdateSequence.Impl do
  def next(num), do: num + 1
  def increment(num, delta), do: num + delta
end
