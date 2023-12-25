defmodule HelloPhoenix.Blog.PostTest do
  use HelloPhoenixWeb.ConnCase, async: true

  test "create and read post" do
    {_, new_post} =
      HelloPhoenix.Blog.Post.create(%{title: "hello", content: "asdf"})

    # |> IO.inspect()

    loaded_post = HelloPhoenix.Blog.Post.get_by_id!(new_post.id)
    # |> IO.inspect()
    #

    assert loaded_post.title == "hello"
  end
end
