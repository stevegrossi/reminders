# Reminders

This is demo Elixir application as part of [a talk I gave at Indy Elixir](http://work.stevegrossi.com/talks/processes-and-supervision-in-elixir). Its purpose is to explore processes and supervision in Elixir, building from scratch and then with `GenServer` a simple console app for storing reminders and being reminded of them.

```elixir
iex> Reminders.Client.remind_me("Buy milk", 3)
:ok
# 3 seconds later...
REMINDER: Buy milk
```
