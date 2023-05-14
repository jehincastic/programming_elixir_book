defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  def start_link(initial_state) do
    GenServer.start_link(@me, initial_state, name: @me)
  end

  def get do
    GenServer.call(@me, { :get })
  end

  def update(state) do
    GenServer.cast(@me, { :update, state })
  end

  def init(init_arg) do
    { :ok, init_arg }
  end

  def handle_call({ :get }, _from, state) do
    { :reply, state, state }
  end

  def handle_cast({ :update, new_state }, _state) do
    { :noreply, new_state }
  end
end
