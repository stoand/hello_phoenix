defmodule HelloPhoenix.JsonRequest do
  use HelloPhoenixWeb.ConnCase, async: true

  def json_request(conn, path, data) do
    conn
    |> put_req_header("content-type", "application/vnd.api+json")
    |> post(path, data)
  end
end
