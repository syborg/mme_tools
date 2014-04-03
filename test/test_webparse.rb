# encoding: utf-8

require 'test/unit'
require '../lib/mme_tools'
require 'date'

#$KCODE = 'u'

class TC_Webparse < Test::Unit::TestCase

  include MMETools::Webparse

  def setup
    extend MMETools::Webparse
    @dirty_text1 = "\xC2\xA0Geolog\xC3\xADa,\n   \n \t  \xC2\xA0 \t Prevenci\xC3\xB3,\tCaçador, Sàtrapa"
    @myself = "Marcel Massana Esteve"
  end

  def test_clear_uri_javascript
    assert_equal '/test/docs/letters/PT.DOC', clear_uri("javascript:openDoc('/test/docs/letters/PT.DOC')")
  end
  
  def test_clear_uri_normal
    assert_equal "http://www.test.tst/test", clear_uri("http://www.test.tst/test")
  end

  def test_clear_string_default
    assert_equal 'Geología, Prevenció, Caçador, Sàtrapa', clear_string(@dirty_text1)
  end
  
  def test_clear_string_ascii
    assert_equal 'Geologia, Prevencio, Cacador, Satrapa', clear_string(@dirty_text1, :encoding => 'ASCII')
  end
  
  def test_asciify
    assert_equal  " Geologia,\n   \n \t    \t Prevencio,\tCacador, Satrapa", asciify(@dirty_text1)
  end
  
  def test_acronymize
    assert_equal "GPCS", acronymize(@dirty_text1)
  end

  def test_acronymize_acronim
    txt = "ANMS"
    assert_equal "A", acronymize(txt)
  end

  def test_acronymize_with_unwanted_words_and_chars
    txt = "partit' socialista de :; - catalunya"
    assert_equal "PSC", acronymize(txt)
  end

  def test_acronymize_with_only_single_letters_and_unwanted_words
    txt = "a b de c"
    assert_equal "ABDC", acronymize(txt)
  end

  def test_acronymize_myself
    assert_equal "MME", acronymize(@myself)
  end

  def test_shorten
    assert_equal "GePrCaSa", shorten(@dirty_text1)
  end

  def test_shorten_string_with_short_words
    txt = "a b de c"
    assert_equal "ABDeC", shorten(txt)
  end

  def test_shorten_myself
    assert_equal "MaMaEs", shorten(@myself)
  end

  def test_datify_yy_lt_69
    res = DateTime.new(2011,12,4)
    assert_equal res, datify("4/12/11")
  end

  def test_datify_yy_gt_69
    res = DateTime.new(1971,12,4)
    assert_equal res, datify("4/12/71")
  end

  def test_datify_dirty_with_hour
    res = DateTime.new(1977,6,1,13,33)
    assert_equal res, datify("sklñ 1-6/1977  - - ,;@ 13:33  oO")
  end

  def test_datify_dirty_with_hour_after_other_words
    res = DateTime.new(1977,6,1)
    assert_equal res, datify("sklñ 1-6/1977  -hola - ,;@ 13:33  oO")
  end


end
