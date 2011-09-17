require 'mme_tools'

require 'rubygems'
require 'test/unit'
require 'rr'


class TC_Config < Test::Unit::TestCase

  include RR::Adapters::TestUnit

  def setup
    @hsh = {
      :param1 => 1,
      :param2 => [2,2],
      :param3 => {
        :subparam1 => 'A',
        :subparam2 => {
          :subsubparam1 => 'END'
        }
      }
    }
    @c = MMETools::Config.new @hsh

  end

  def test_first_level_parameter_basic
    assert_equal 1, @c.param1
  end

  def test_first_level_parameter_complex
    assert_equal [2,2] , @c.param2
  end

  def test_second_level_parameter
    assert_equal 'A', @c.param3.subparam1
  end

  def test_third_level_parameter
    assert_equal 'END', @c.param3.subparam2.subsubparam1
  end

  def test_to_hash
    assert_equal @hsh, @c.to_hash
  end

  def test_create_with_block
    cfg = MMETools::Config.new do |c|
      c.param1 = 1
      c.param2 = [2,2]
      c.param3 = {
        :subparam1 => 'A',
        :subparam2 => {
          :subsubparam1 => 'END'
        }
      }
    end
    assert_equal @hsh, cfg.to_hash
  end

  def test_create_with_load
    stub(YAML).load_file('dummy_config') { @hsh.dup }
    cfg = MMETools::Config.load 'dummy_config'
    assert_equal @hsh, cfg.to_hash
  end

end
