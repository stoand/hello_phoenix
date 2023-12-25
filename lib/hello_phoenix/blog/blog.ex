defmodule HelloPhoenix.Blog do
  use Ash.Api,
    extensions: [AshJsonApi.Api]

  resources do
    resource HelloPhoenix.Blog.Post
  end
end
