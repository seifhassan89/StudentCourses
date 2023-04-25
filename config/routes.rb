Rails.application.routes.draw do
  # sawgger
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # application routes
  resources :students
  resources :genders
  resources :courses
  resources :departments
  
  # Defines the root path route ("/")
  root "students#index"
end
