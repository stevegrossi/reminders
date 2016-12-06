defmodule Reminders.Client do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def remind_me(message, seconds_in_future) do
    GenServer.cast(__MODULE__, {:new, message, seconds_in_future})
  end

  # Callbacks

  def handle_cast({:new, message, seconds_in_future}, state) do
    milliseconds = seconds_in_future * 1000
    Process.send_after(self(), {:reminder, message}, milliseconds)
    {:noreply, state}
  end

  def handle_info({:reminder, message}, state) do
    IO.puts("REMINDER: #{message}")
    {:noreply, state}
  end

end
