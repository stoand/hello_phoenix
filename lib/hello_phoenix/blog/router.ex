defmodule HelloPhoenix.Blog.Router do
  use AshJsonApi.Api.Router,
    apis: [HelloPhoenix.Blog],
    json_schema: "/json_schema",
    open_api: "/open_api"
end
