defmodule HelloPhoenix.Blog.PostTest do
  use HelloPhoenixWeb.ConnCase, async: true
  import HelloPhoenix.JsonRequest

  test "create and read post" do
    {_, new_post} = HelloPhoenix.Blog.Post.create(%{title: "hello", content: "asdf"})

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

  test "can create a post through http", %{conn: conn} do
    conn =
      json_request(conn, ~p"/posts", %{
        data: %{type: "post", attributes: %{title: "hello", content: "interesting stuff"}}
      })

    assert json_response(conn, 201) |> Map.get("data") != nil
  end

  test "can create post stats" do
    # HelloPhoenix.Blog.Post.get_first_title!(%{})
    # |> IO.inspect()
    stats = HelloPhoenix.Blog.PostStats.create!(%{})
    HelloPhoenix.Blog.Post.create!(%{title: "asdf", content: "stuff", post_stats_id2: stats.id})

    load =
      HelloPhoenix.Blog.PostStats
      |> Ash.Query.load([:id, :post_count, :posts])
      |> HelloPhoenix.Blog.read!()
      |> IO.inspect()

      

    # post_stats = HelloPhoenix.Blog.PostStats.read!(load: )

    # post_stats
    # |> IO.inspect()
  end
end
