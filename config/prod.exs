use Mix.Config

config :hedwig_weather,
  location: System.get_env("LOCATION"),
  darksky_key: System.get_env("DARKSKY_KEY")
