defmodule HelloPhoenixWeb.ErrorJSONTest do
  use HelloPhoenixWeb.ConnCase, async: true

  test "asdf" do
    new_post = HelloPhoenix.Blog.Post.create!(%{title: "hello", content: "asdf"})
      


    HelloPhoenix.Blog.Post
    |> Ash.Query.for_read(:by_id, %{id: new_post.id})
    |> HelloPhoenix.Blog.read!()
    |> IO.inspect()
    
  end

  test "renders 404" do
    assert HelloPhoenixWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert HelloPhoenixWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
