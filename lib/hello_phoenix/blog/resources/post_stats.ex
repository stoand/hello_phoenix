defmodule HelloPhoenix.Blog.PostStats do
  use Ash.Resource,
    # data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource],
    authorizers: [Ash.Policy.Authorizer]

  json_api do
    type "post_stats"

    routes do
      base "/posts_stats" 

      get :read 
      index :read
      post :create
    end
  end

  actions do
    defaults [:read]
  end

  attributes do
    uuid_primary_key :id
  end

  relationships do
    has_many :posts, HelloPhoenix.Blog.Post do
      no_attributes? true
    end
  end
  
  aggregates do
    count :post_count_with_content, :posts do
      filter expr(content != nil)
    end
  end
end

