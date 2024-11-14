Rails.application.routes.draw do
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope  :api  do  
    scope  :v1 do 
      resources :user do 
        collection do
          post 'post_user_details', to: 'user#postUserDetails' 
          post 'user_signin', to: 'user#userLogin'
          get 'getToken' ,  to: 'user#getToken'
        end
      end
  end 
end
# config/routes.rb
#   namespace :api do
#     namespace :v1 do
    
#       post 'userLogin', to: 'user#userLogin'
#       post 'userDetails', to: 'user#postUserDetails' 
#       resources :users, only: [] do
#         # You can add more custom routes here if necessary
#       end
#     end
#   end
end 


# {
#     "user": {
#         "id": 1,
#         "email": "users@example.com",
#         "created_at": "2024-11-11T16:34:35.713Z",
#         "updated_at": "2024-11-11T16:34:35.713Z",
#         "password_digest": "$2a$12$2IKb5mytlEmeTU3Iv8oBe.J4Rvf7XnXKJqYR/S24VpObFspDePaA."
#     }
# }