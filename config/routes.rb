Refinery::Core::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :images, only: [:index, :show]

      resources :pages do
        resources :page_parts
      end

      resources :resources, only: [:index, :show]
    end

    match 'v:api/*path', to: redirect("/api/v1/%{path}"), via: [:get, :post, :put, :patch, :delete]
    match '*path', to: redirect("/api/v1/%{path}"), via: [:get, :post, :put, :patch, :delete]
  end
end
