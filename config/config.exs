# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :navii, Navii.Robot,
  adapter: Hedwig.Adapters.IRC,
  name: System.get_env("IRC_NICK") || "alfred_bot",
  aka: (System.get_env("IRC_NICK") || "alfred_bot") |> String.downcase,
  irc_user: System.get_env("IRC_USER") || "alfred_bot",
  full_name: System.get_env("IRC_NAME") || "Alfred Bot", # optional, defaults to `:name`
  password: System.get_env("IRC_PASS") || "",
  server: "chat.freenode.net",
  port: 6697, # optional, defaults to `6667`
  ssl?: true, # optional, defaults to `false`
  rooms:
    (System.get_env("IRC_CHANNELS") || "")
    |> String.split(",")
    |> Enum.map(&({&1, ""})),
  responders: [
    {Hedwig.Responders.Help, []},
    {Hedwig.Responders.Ping, []},
    {HedwigSimpleResponders.Fishpun, []},
    {HedwigSimpleResponders.Flip, []},
    {HedwigSimpleResponders.Slogan, []},
    {HedwigSimpleResponders.Stallman, []},
    {HedwigSimpleResponders.Time, []},
    {HedwigSimpleResponders.Uptime, []},
    {Hedwig.Responders.Weather, []},
    {Hedwig.Responders.Currency, []},
    {Hedwig.Responders.Youtube, []},
    {Navii.Responders.Overhear, []},
    {Navii.Responders.Inspire, []},
  ]

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

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
import_config "#{Mix.env}.exs"
