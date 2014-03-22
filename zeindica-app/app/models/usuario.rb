class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :nome, :facebook_link, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

	has_one :authentication, :dependent => :destroy
	has_many :cupons
	
	def facebook
		@facebook ||= FbGraph::User.me(self.authentication.token)
	end

	def apply_omniauth(auth)
		# In previous omniauth, 'user_info' was used in place of 'raw_info'
  	self.email = auth['info']['email']
		self.nome = auth['extra']['raw_info']['name']
		self.facebook_link = auth['extra']['raw_info']['link']		
		# Again, saving token is optional. 
		# If you haven't created the column in authentications table, this will fail
  	self.authentication = Authentication.create(
			:provider => auth['provider'], 
			:uid => auth['uid'], 
			:token => auth['credentials']['token'])
	end

	def admin?
		return self.admin
	end
end
