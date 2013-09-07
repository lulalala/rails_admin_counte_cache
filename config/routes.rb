Ct::Application.routes.draw do
  devise_for :users, :skip => :registrations

  mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'
end
