defmodule UpdateSequence.Server do
  use GenServer
  alias UpdateSequence.Impl

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, _from, curr_number) do
    {:reply, curr_number, Impl.next(curr_number)}
  end

  def handle_cast({:increment_number, delta}, curr_number) do
    {:noreply, Impl.increment(curr_number, delta)}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
