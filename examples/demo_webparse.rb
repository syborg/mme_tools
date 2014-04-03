# Some dirty tests on MMETools::Webparse
# Marcel Massana 3-Sep-2011

#require 'rubygems'
require '../lib/mme_tools/webparse'

WP = MMETools::Webparse

a="ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüý"
b="AAAAAACEEEEIIIIDNOOOOOxOUUUUYaaaaaaceeeeiiiinoooooouuuuy"

dirty_text = "\xC2\xA0Geolog\xC3\xADa,\n   \n \t  \xC2\xA0 \t Prevenci\xC3\xB3,\tCaçador, Sàtrapa"

puts a.chars.map.class, b.split('').class

p WP.clear_string dirty_text                        # => "Geología, Prevenció, Caçador, Sàtrapa"
p WP.clear_string dirty_text, :encoding => 'ASCII'  # => "Geologia, Prevencio, Cacador, Satrapa"
p WP.asciify dirty_text                             # =>  " Geologia,\n   \n \t    \t Prevencio,\tCacador, Satrapa"

# datify

puts WP.datify("1/2/10")