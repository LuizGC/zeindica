#encoding: utf-8
class Cupom < ActiveRecord::Base  
	attr_accessible :depositado, :premiado, :premio, :usuario
	
	belongs_to :usuario
  belongs_to :premio


	validates_presence_of :usuario
  validates_presence_of :premio

	def depositado?
		sim_nao(self.depositado)
	end

 private
 	def sim_nao(boolean)
		if boolean
			"Sim"
		else
			"Não"
		end
	end

end
