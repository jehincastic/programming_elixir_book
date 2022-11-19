defmodule BadFactorial do
  def of(n), do: n * of(n-1)
  def of(0), do: 1
end

# Elixir tries functions from the top down, executing the first match.
# The first function definition will always match and the second will never be called.
