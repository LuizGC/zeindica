class ApplicationController < ActionController::Base
  protect_from_forgery


	private 
	def login_required
		if usuario_signed_in?
			unless current_usuario.admin?
				redirect_to root_path
			end
		else
			redirect_to "/auth/facebook/"
		end
	end
end
