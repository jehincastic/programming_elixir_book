defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def add_to_stack(val) do
    GenServer.call(__MODULE__, {:push, val})
  end

  def remove_from_stack do
    GenServer.call(__MODULE__, :pop)
  end

  def init(initial_state \\ []) do
    {:ok, initial_state}
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
