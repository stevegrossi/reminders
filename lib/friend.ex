defmodule Friend do

  def listen do
    receive do
      :hi ->
        IO.puts("Hello there!")
        listen()
      _ ->
        nil
    end
  end
end
