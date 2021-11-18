Rails.application.routes.draw do
  root 'home#index', as:'home'
  get 'account/signup', as:'signup'
  post 'account/signup', to:'account#create', as: 'create'
  get 'account/login', as:'login'
  post 'account/login', as:'login_enter'
  get 'account/logout', as:'logout'
  delete 'account/delete', as:'delete_account'
  get 'profile/edit_profile', as:"edit_profile"
  post 'profile/edit_profile', to:'profile#update_profile', as:"update_profile"
  get 'password/forget_password', as:'forget_password'
  post 'password/forget_password', as:'forget_password_post'
  get 'password/reset_password', as:'reset_password'
  post 'password/reset_password', as:'reset_password_post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
