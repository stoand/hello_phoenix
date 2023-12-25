defmodule HelloPhoenixWeb.ErrorJSONTest do
  use HelloPhoenixWeb.ConnCase, async: true

  test "asdf" do
    {_, new_post} =
      HelloPhoenix.Blog.Post.create(%{title: "hello", content: "asdf"})
      |> IO.inspect()

    HelloPhoenix.Blog.Post.get_by_id!(new_post.id)
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
