class Empresa < ActiveRecord::Base
  attr_accessible :nome, :telefone, :imagem_topo, :imagem_meio, :imagem_inferior, :link_to_imagem_topo,  :link_to_imagem_meio,  :link_to_imagem_inferior

	has_attached_file :imagem_topo

	has_attached_file :imagem_meio

	has_attached_file :imagem_inferior

	validates_presence_of :nome

	validates_uniqueness_of :nome, :case_sensitive => false

	has_many :premios

end
