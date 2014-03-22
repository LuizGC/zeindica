class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :usuario_id

	belongs_to :usuario
end
