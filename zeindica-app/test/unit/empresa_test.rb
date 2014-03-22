require 'test_helper'

class EmpresaTest < ActiveSupport::TestCase
  
	test "the truth" do
		assert true
  end

	def test_should_be_invalid
  	empresa = create(:nome => "", :telefone => "")
  	assert !empresa.valid?, "Empresa shouldn't be created"
	end

	def test_should_require_nome
  	empresa = create(:nome => "")
  	assert empresa.errors[:nome].any?, ":nome should be required"
  	assert !empresa.valid?, "Empresa shouldn't be created"
	end

	def test_should_require_telefone
  	empresa = create(:telefone => "")
  	assert empresa.errors[:telefone].any?, ":telefone should be required"
  	assert !empresa.valid?, "Empresa shouldn't be created"
	end

 def test_should_deny_duplicate_empresa
    empresa = create
    assert empresa.valid?, "Empresa should be created"

    empresa = create
    assert !empresa.valid?, "Empresa shouldn't be created"
  end

	def test_should_require_longer_telefone
    empresa = create(:telefone => '1')
    assert empresa.errors[:telefone].any?, ":telefone should be 8 characters or longer"
    assert !empresa.valid?, "Empresa shouldn't be created"
  end

	def test_should_require_imagem_topo
		empresa = create(:imagem_topo => nil)
		assert empresa.errors[:imagem_topo].any?, ":imagem_topo should be required"
		assert !empresa.valid?, "Empresa shouldn't be created"
	end

	def test_should_require_imagem_meio
		empresa = create(:imagem_meio => nil)
		assert empresa.errors[:imagem_meio].any?, ":imagem_meio should be required"
		assert !empresa.valid?, "Empresa shouldn't be created"
	end


	def test_should_require_imagem_inferior
		empresa = create(:imagem_inferior => nil)
		assert empresa.errors[:imagem_inferior].any?, ":imagem_inferior should be required"
		assert !empresa.valid?, "Empresa shouldn't be created"
	end


	private
    def create(options={})
      Empresa.create({
        :nome => "Homer Simpson",
        :telefone => "8445 0980",
				:imagem_topo =>upload_file_path,
				:imagem_meio => upload_file_path,
				:imagem_inferior =>upload_file_path
			}.merge(options))
    end

end
