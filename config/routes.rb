Rails.application.routes.draw do
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # creating socket end points 
  mount ActionCable.server => '/wrtc'

  root to: 'chat#chat_boot'


  scope  :api  do  
    scope  :v1 do 
      resources :user do 
        collection do
          post 'post_user_details', to: 'user#postUserDetails' 
          get 'sign_up', to: 'user#sign_up' 
          post 'user_signin', to: 'user#userLogin'
          get 'login', to: 'user#login'
          delete 'logout', to: 'user#logout' 
          get 'getToken' ,  to: 'user#getToken'

          ########################## api routes 
          post 'mob_post_user_details', to: 'user#mob_post_user_details' 
          post 'user_login', to: 'user#mob_user_login'
         end
      end

      # resources :books  # , only: [:getBooks]      
      get "books" ,  to: 'book#getBooks'
      get "chat_boot" ,  to: 'chat#chat_boot'
      post  "create_room",  to: 'chat#create_room' 
    
  end 
end

end 


