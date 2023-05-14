defmodule Stack.Server do
  use GenServer

  alias Stack.Stash
  alias Stack.Impl

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def add_to_stack(val) do
    GenServer.call(__MODULE__, {:push, val})
  end

  def remove_from_stack do
    GenServer.call(__MODULE__, :pop)
  end

  def init(_) do
    { :ok, Stash.get }
  end

  def handle_call({:push, data}, _from, state) do
    new_state = Impl.add(data, state)
    {:reply, new_state, new_state}
  end

  def handle_call(:pop, _from, state) do
    {val, new_state} = Impl.remove(state)
    {:reply, val, new_state}
  end

  def terminate(_reason, state) do
    Stash.update(state)
  end
end
