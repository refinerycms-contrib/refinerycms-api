Refinery::Core::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :images

      resources :pages do
        resources :page_parts
      end

      resources :resources

      namespace :blog do
        resources :posts
      end

      namespace :inquiries do
        resources :inquiries, only: [:new, :create, :index, :show, :destroy]
      end
    end

    match 'v:api/*path', to: redirect("/api/v1/%{path}"), via: [:get, :post, :put, :patch, :delete]
    match '*path', to: redirect("/api/v1/%{path}"), via: [:get, :post, :put, :patch, :delete]
  end
end
