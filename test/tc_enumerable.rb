require 'test/unit'
require 'mme_tools'

class TC_Enumerable < Test::Unit::TestCase

  include MMETools::Enumerable

  def setup
    @a=(1..12).to_a
    @b=("A".."M").to_a
    @c=%w{tantmateix adhuc nogensmenys urgell pocassolta carrincló bajanada casundena Massalcoreig}
  end

  def test_compose
    assert_equal [2,"B","adhuc"], compose(@a,@b,@c)[1]
  end

  def test_classify
    assert_equal "Massalcoreig", classify(@c) {|v| v.length}[12][0]
  end

  def test_even_values
    assert_equal [1,3,5,7,9,11], even_values(@a)
  end
  
  def test_odd_values
    assert_equal [2,4,6,8,10,12], odd_values(@a)
  end
  
  def test_compose_what_has_been_decomposed
    assert_equal @c, compose(even_values(@c), odd_values(@c)).flatten.compact
  end
end
