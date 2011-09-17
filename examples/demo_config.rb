# demo de utilitzacio de MMETools::Config
# Marcel Massana 11-Sep-2011

require 'mme_tools/config'
require 'pp'

config_file = File.expand_path('tmp/config.yml',File.dirname(__FILE__))

config1 = MMETools::Config.new

# when creating a config choose any name u want to store values (only one level)
config1.name = "Joana"
config1.surname = "Peterson"
config1.any_name_u_want = "anyname"
config1.contact = {:emails => ['jo@ana.com', 'j_ana@gmail.com']}
config1.also = ['Hi There']


#
config1.dump config_file

pp config1.contact.emails

config2 = MMETools::Config.new
config2.load config_file

# when accessing an already made config u can access hashes to end level with a
# simple syntax
pp config2.contact.emails
pp config2.also

# Instantiating a config directly by loading
config3 = MMETools::Config.load config_file
pp config2.contact.emails
pp config2.also


config4 = MMETools::Config.new do |c|
  c.param1 = "Hola"
  c.param2 = %w[a b c]
  c.param3 = {:a => {:A=> 'jorl'}, :b => 2}
end

pp config4
pp config4.to_hash