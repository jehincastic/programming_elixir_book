defmodule Sequence.Server do
  use GenServer

  def init(initial_number) do
    { :ok, initial_number }
  end

  def handle_call(:next_number, _from, curr_number) do
    { :reply, curr_number, curr_number + 1 }
  end

  def handle_call({ :set_number, new_number }, _from, _curr_number) do
    { :reply, new_number, new_number }
  end

  def handle_cast({ :increment_number, delta }, curr_number) do
    { :noreply, curr_number + delta }
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
