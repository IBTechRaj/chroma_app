class UserSerializer
include FastJsonapi::ObjectSerializer

    attributes  :id, :name,  :email, :role, :get_profile_pic_url
  
end

