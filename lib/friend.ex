defmodule Friend do

  def listen(state \\ %{}) do
    receive do
      {:set, key, value} ->
        new_state = Map.put(state, key, value)
        listen(new_state)
      {:get, key} ->
        IO.puts(Map.get(state, key))
        listen(state)
      _ ->
        nil
    end
  end
end
