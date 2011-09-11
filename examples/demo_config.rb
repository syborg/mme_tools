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
config1.also = [{:a=>'A', :'b'=>'B'},'Hi There']


#
config1.dump config_file

pp config1

config2 = MMETools::Config.new
config2.load config_file

# when accessing an already made config u can access hashes to end level with a
# simple syntax
pp config2.contact.emails
pp config2.also