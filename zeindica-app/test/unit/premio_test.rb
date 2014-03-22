require 'test_helper'

class PremioTest < ActiveSupport::TestCase

   test "the truth" do
     assert true
   end

	def test_should_be_invalid
		premio = create(:nome=>"", :sorteio => Time.now.to_date, :descricao => "", :empresa_id => 0)
		assert !premio.valid?, "Premio shouldn't be created"
	end 

	def test_should_require_nome
  	premio = create(:nome => "")
  	assert premio.errors[:nome].any?, ":nome should be required"
  	assert !premio.valid?, "Premio shouldn't be created"
	end

	def test_should_deny_non_integer_empresa
  	premio = create(:empresa_id => 'a')
  	assert premio.errors[:empresa_id].any?, ":empresa_id should have had an error"
  	assert !premio.valid?, "Post shouldn't be created"

  	premio = create(:empresa_id => 1.397)
  	assert premio.errors[:empresa_id].any?, ":empresa_id should have had an error"
 		assert !premio.valid?, "Post shouldn't be created"
	end

	def test_should_check_premio_authorship
		assert_equal 0, empresas(:one).premios.size, "empresa should have had 0 premios"
 		premio = create(:empresa_id => nil)
 	 	empresas(:one).premios << premio
  	assert_equal 1, empresas(:one).premios.size, "empresa should have had 1 premios"
		premio = create(:empresa_id => 100)
		assert premio.errors[:empresa].any?, "Empresa doesn't exist, so it should be required"

end

	def test_should_require_imagem_nuvem
  	premio = create(:imagem_nuvem => nil)
  	assert premio.errors[:imagem_nuvem].any?, ":imagem_nuvem should exist"
  	assert !premio.valid?, "Premio shouldn't be created"
	end

	def test_should_require_imagem_info
  	premio = create(:imagem_info => nil)
  	assert premio.errors[:imagem_info].any?, ":imagem_info should exist"
  	assert !premio.valid?, "Premio shouldn't be created"
	end


	private 
		def create(options={})
			premio = Premio.create({
				:nome => "Premio teste",
				:sorteio => Time.now.to_date, 
				:descricao => "Descricao do Premio",
				:empresa_id => 1,
				:imagem_nuvem => upload_file_path,
				:imagem_info => upload_file_path
			}.merge(options))
		end
end
