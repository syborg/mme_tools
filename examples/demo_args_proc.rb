# demo for named_args
# Marcel Massana 13-Sep-2011

#require 'rubygems'
require '../lib/mme_tools/args_proc'

class Dummy

  include MMETools::ArgsProc

  def initialize(arg1, arg2, options={})
    # this is an options pattern to check against passed options
    default_opts = {
      :name => 'Marcel',
      :surname => 'Massana',
      :email => nil
    }
    assert_valid_keys options, default_opts
    options.each do |k|
      p k
    end
  end

end

d=Dummy.new 1,2,:name => 'Bartolo', :email => 'j'
