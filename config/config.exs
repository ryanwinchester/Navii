# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :navii, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:navii, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# config :navii, bot: %{
#   server: "chat.freenode.net", port: 6667,
#   nick: "navii_ex", user: "navii_ex", name: "Navii Elixir",
#   channel: "#flashtag", pass: ""
# }

config :kuma,
  bot: %{
    server: "chat.freenode.net",
    port: 6697,
    name: "Navii Elixir Bot",
    nick: System.get_env("IRC_NICK") || "Navii Bot",
    user: System.get_env("IRC_USERNAME") || "navii_bot",
    pass: System.get_env("IRC_PASSWORD") || "",
    channels: (System.get_env("IRC_CHANNELS") || "") |> String.split(","),
  },
  custom_handlers: [
    Navii.Overhear,
  ]

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
