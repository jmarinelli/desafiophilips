Desafiophilips::Application.routes.draw do
  root 'site#index'
  post '/' => 'site#login'
  get '/home' => 'site#home'

  namespace :api do
    scope 'users' do
      get '' => 'user#index'
      get ':id' => 'user#show'
      get ':id/ranking' => 'user#ranking'
    end

    scope 'trivia' do
      get 'users/:id/questions' => 'trivia#questions_for_user'
      get 'users/:id/next-question' => 'trivia#next_question_for_user'
      post 'users/:id/answers' => 'trivia#answer'
      get 'questions' => 'trivia#index'
      get 'questions/:id' => 'trivia#show'
    end

    scope 'companies' do
      get '' => 'company#index'
      get ':id/users' => 'company#users'
      get ':id/users/clusters/:cluster_id' => 'company#cluster_users'
      get ':id/users/clusters/:cluster_id/ranking' => 'company#cluster_ranking', position: 'vendedor'
      get ':id/subsidiaries/ranking' => 'company#subsidiary_ranking'
      get ':id/products' => 'product#index'
      get ':id/subsidiaries' => 'subsidiary#index'
    end

    get 'clusters/:id/subsidiaries' => 'subsidiary#by_cluster'
    get 'categories' => 'category#index'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
