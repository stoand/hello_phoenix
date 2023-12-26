defmodule HelloPhoenix.Blog do
  use Ash.Api,
    extensions: [AshJsonApi.Api]

  resources do
    resource HelloPhoenix.Blog.Post
    resource HelloPhoenix.Blog.PostStats
  end
end
