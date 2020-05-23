Rails.application.routes.draw do
  resources :schedule_dates do
    post 'bulk', on: :collection
    get 'destroy_all', on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
