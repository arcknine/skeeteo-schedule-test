Rails.application.routes.draw do
  resources :vessels, except: [:index] do
    resources :routes,  except: [:index]
  end

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"
end
