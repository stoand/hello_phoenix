defmodule HelloPhoenix.Repo do
  use AshPostgres.Repo, otp_app: :hello_phoenix

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
