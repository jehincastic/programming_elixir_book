defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

  def init(_) do
    {:ok, []}
  end

  def handle_call({:push, data}, _from, state) do
    new_state = Impl.add(data, state)
    {:reply, new_state, new_state}
  end

  def handle_call(:pop, _from, state) do
    {val, new_state} = Impl.remove(state)
    {:reply, val, new_state}
  end

  def terminate(reason, state) do
    IO.inspect({ reason, state })
  end
end
