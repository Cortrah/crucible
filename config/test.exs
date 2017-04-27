use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :crucible, Crucible.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :crucible, Crucible.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "crucible_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
