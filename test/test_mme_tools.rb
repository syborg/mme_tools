require 'test/unit'
require 'mme_tools'

Dir[File.join("**","tc_*")].each {|f| require f}  # any file beginning in 'tc_' here or in subdirs