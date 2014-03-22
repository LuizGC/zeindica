require 'test_helper'

class EmpresasHelperTest < ActionView::TestCase

	def deny(condition, message='')
  	assert !condition, message
	end

	def assert_invalid(record, message='')
  	deny record.valid?, message
	end

end
