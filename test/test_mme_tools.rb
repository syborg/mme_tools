require 'test/unit'
require 'mme_tools'

A=1..12
B="A".."M"
C=%w{tantmateix adhuc nogensmenys urgell pocasolta carrincló}

class TC_MmeTools < Test::Unit::TestCase

  def setup
  end

  def teardown
  end
  
  def test_compose
    assert_equal [2,"B","adhuc"], MMETools::Enumerable.compose(A,B,C)[1]
  end
end
