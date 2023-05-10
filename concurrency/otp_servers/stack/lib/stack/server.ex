defmodule Stack.Server do
  use GenServer

  def init(_) do
    { :ok, [] }
  end

  def handle_call({ :push, data }, _from, state) do
    new_state = [data | state]
    { :reply, new_state, new_state }
  end

  def handle_call({ :pop }, _from, state) do
    [val | new_state] = state
    { :reply, val, new_state }
  end
end
