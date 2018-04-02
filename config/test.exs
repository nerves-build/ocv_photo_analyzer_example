use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ocv_photo_analyzer_example, OcvPhotoAnalyzerExampleWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ocv_photo_analyzer_example, OcvPhotoAnalyzerExample.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "postgres",
  password: "postgres",
  database: "ocv_photo_analyzer_example_test",
  hostname: "localhost",
  port: "8889",
  pool: Ecto.Adapters.SQL.Sandbox

config :upload, Upload, adapter: Upload.Adapters.Test
