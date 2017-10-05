# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :font_converter,
  ecto_repos: [FontConverter.Repo]

# Configures the endpoint
config :font_converter, FontConverterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OE/8FnW1b4ErkFpFa4CZvAapDkqJNL5Z7ti/jsG5IyEvVQY9w/JBp8l9kwo9idG2",
  render_errors: [view: FontConverterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FontConverter.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
