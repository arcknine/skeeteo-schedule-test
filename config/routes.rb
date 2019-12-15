Rails.application.routes.draw do
  get 'schedules/new'
  get 'schedules/edit'
  resources :vessels, except: [:index] do
    resources :routes,  except: [:index] do
      resources :schedules, except: [:index, :show]
    end

    resources :schedules, except: [:index, :show]
    member do
      get :calendar
      get :feed
    end
  end

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"
end
