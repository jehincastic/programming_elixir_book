defmodule Stack.Impl do
  def add(val, stack), do: [val | stack]
  def remove(stack) do
    [val | new_state] = stack
    {val, new_state}
  end
end
