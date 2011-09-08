# Some dirty tests on MMETools::Webparse
# Marcel Massana 3-Sep-2011

require 'rubygems'
require 'mme_tools/webparse'

module WP
  extend MMETools::Webparse
end

a="ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüý"
b="AAAAAACEEEEIIIIDNOOOOOxOUUUUYaaaaaaceeeeiiiinoooooouuuuy"

dirty_text = "\xC2\xA0Geolog\xC3\xADa,\n   \n \t  \xC2\xA0 \t Prevenci\xC3\xB3,\tCaçador, Sàtrapa"

puts a.chars.map.class, b.split('').class

p WP.clear_string dirty_text # => "Geología, Prevenció, Caçador, Sàtrapa"
p WP.clear_string dirty_text, :encoding => 'ASCII'