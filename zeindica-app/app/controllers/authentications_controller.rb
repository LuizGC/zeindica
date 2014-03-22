class AuthenticationsController < ApplicationController
	
	def create
  	auth = request.env["omniauth.auth"]
 
  	# Try to find authentication first
 		authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
 
  	if authentication
    	# Authentication found, sign the usuario in.
    	flash[:notice] = "Signed in successfully."
    	sign_in_and_redirect(:usuario, authentication.usuario)
  	else
    	# Authentication not found, thus a new usuario.
    	usuario = Usuario.new
    	usuario.apply_omniauth(auth)
    	if usuario.save(:validate => false)
      	flash[:notice] = "Account created and signed in successfully."
      	sign_in_and_redirect(:usuario, usuario)
    	else
      	flash[:error] = "Error while creating a usuario account. Please try again."
      	redirect_to root_url
    	end
  	end
	end


end
