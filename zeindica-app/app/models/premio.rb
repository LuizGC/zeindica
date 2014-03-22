class Premio < ActiveRecord::Base
  attr_accessible :descricao, :empresa_id, :nome, :sorteio, :imagem_nuvem, :imagem_info

	validates_presence_of :nome
	validates_numericality_of :empresa_id, :only_integer => true
	validates_presence_of :sorteio

	has_attached_file :imagem_nuvem
	
	has_attached_file :imagem_info

	belongs_to :empresa
	validates_associated :empresa
	validates_presence_of :empresa
	
	has_many :cupons


end
