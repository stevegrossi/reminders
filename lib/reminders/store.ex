defmodule Reminders.Store do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def save({message, timestamp}) do
    GenServer.cast(__MODULE__, {:save, {message, timestamp}})
  end

  def pop_past_reminders do
    GenServer.call(__MODULE__, :pop_past_reminders)
  end

  # Callbacks

  def handle_cast({:save, {message, timestamp}}, state) do
    new_state = [{message, timestamp} | state]
    {:noreply, new_state}
  end

  def handle_call(:pop_past_reminders, _caller, state) do
    past_reminders = Enum.filter(state, fn({_message, timestamp}) ->
      timestamp <= :os.system_time(:seconds)
    end)
    new_state = state -- past_reminders
    {:reply, past_reminders, new_state}
  end
end
