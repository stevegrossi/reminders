defmodule Friend do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def handle_cast({:set, key, value}, state) do
    new_state = Map.put(state, key, value)
    {:noreply, new_state}
  end

  def handle_call({:get, key}, _sender, state) do
    response = Map.get(state, key)
    {:reply, response, state}
  end
end
