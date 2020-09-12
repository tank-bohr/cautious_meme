# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cautious_meme,
  ecto_repos: [CautiousMeme.Repo]

# Configures the endpoint
config :cautious_meme, CautiousMemeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hyWIndS3P6p+tNz+56RsjcwAbmuv5SThKXKGaysG9285n9/dh5MXut3GMw6E5MCq",
  render_errors: [view: CautiousMemeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CautiousMeme.PubSub,
  live_view: [signing_salt: "hapHUGOl"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
