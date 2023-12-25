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

  test "title cannot be asdf", %{conn: conn} do
    HelloPhoenix.Blog.Post.create(%{title: "hello", content: "asdf"})
    HelloPhoenix.Blog.Post.create(%{title: "asdf", content: "asdf"})

    conn = get(conn, ~p"/posts")
    assert json_response(conn, 200) |> Map.get("data") |> length() == 1
  end
end
