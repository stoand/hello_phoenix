defmodule HelloPhoenix.Blog do
  use Ash.Api

  resources do
    resource HelloPhoenix.Blog.Post
  end
end
