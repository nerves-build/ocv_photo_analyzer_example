# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ocv_photo_analyzer_example, ecto_repos: [OcvPhotoAnalyzerExample.Repo]

# Configures the endpoint
config :ocv_photo_analyzer_example, OcvPhotoAnalyzerExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oRZfKQ8hxtLYWPryZAcsyldj8sYWSk2+5fuLzAY4JLZSjQkdbzp1yZdczAXdQ4WE",
  render_errors: [view: OcvPhotoAnalyzerExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OcvPhotoAnalyzerExample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :upload, Upload, adapter: Upload.Adapters.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
