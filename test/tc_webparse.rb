require 'test/unit'
require 'mme_tools'

$KCODE = 'u'

class TC_Webparse < Test::Unit::TestCase

  include MMETools::Webparse

  def setup
    extend MMETools::Webparse
    @dirty_text1 = "\xC2\xA0Geolog\xC3\xADa,\n   \n \t  \xC2\xA0 \t Prevenci\xC3\xB3,\tCaçador, Sàtrapa"
  end

  def test_clear_uri
    assert_equal '/test/docs/letters/PT.DOC', clear_uri("javascript:openDoc('/test/docs/letters/PT.DOC')")
    assert_equal "http://www.test.tst/test", clear_uri("http://www.test.tst/test")
  end

  def test_clear_string
    assert_equal 'Geología, Prevenció, Caçador, Sàtrapa', clear_string(@dirty_text1)
    assert_equal 'Geologia, Prevencio, Cacador, Satrapa', clear_string(@dirty_text1, :encoding => 'ASCII')
  end

end
