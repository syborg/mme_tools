# mme_tools/webparse
# Marcel Massana 1-Sep-2011

require 'rubygems'
require 'iconv'
require 'unicode'
require 'jcode' if RUBY_VERSION < '1.9'

$KCODE = "u"

module MMETools

  # methods for processing strings while parsing webpages
  module Webparse

    extend self # elegant truc per a que tots els metodes siguin class/module methods 
    
    # torna una uri treient-hi les invocacions javascript si n'hi ha. Per exemple
    #   "javascript:openDoc('/gisa/documentos/cartes/PT.DOC')" -> "/gisa/documentos/cartes/PT.DOC"
    def clear_uri uri
      case uri
      when /Doc\('.*'\)/ then uri.match(/Doc\('(.*)'\)/).captures[0]
      else uri
      end
    end

    # treu els espais innecessaris i codis HTML d'enmig i extrems a un string
    # neteja l'string eliminant tots els no printables dels extrems i els
    # d'enmig els substitueiux per un unic espai.
    # Les opcions poden ser:
    #   +:encoding+ => "ASCII" | "UTF8" (default)
    #     "ASCII" converteix tots els caracters al mes semblant ASCII (amb Iconv)
    #     "UTF8" torna una cadena UTF8
    # (based on an idea of Obie Fernandez http://www.jroller.com/obie/tags/unicode)
    def clear_string(str, options={:encoding=>'UTF8'})
      str=str.chars.map { |c| (c[0] <= 127) ? c : translation_hash[c] }.join if options[:encoding]=='ASCII'
      str.gsub(/[\s\302\240]+/mu," ").strip # el caracter UTF8 "\302\240" correspon al &nbsp; de HTML
    end
## La versio original basada en Iconv no funciona en algunes circumstancies
#    def orig_clear_string(str, options={:encoding=>'UTF8'})
#      str=Iconv.conv('ASCII//TRANSLIT//IGNORE', 'UTF8', str) if options[:encoding]=='ASCII'
#      str.gsub(/[\s\302\240]+/mu," ").strip # el caracter UTF8 "\302\240" correspon al &nbsp; de HTML
#    end

    protected

    def translation_hash
      @@translation_hash ||= setup_translation_hash
    end

    def setup_translation_hash
      accented_chars   = "ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüý".chars.map{|c| c}
      unaccented_chars = "AAAAAACEEEEIIIIDNOOOOOxOUUUUYaaaaaaceeeeiiiinoooooouuuuy".split('')

      translation_hash = {}
      accented_chars.each_with_index { |char, idx| translation_hash[char] = unaccented_chars[idx] }
      translation_hash["Æ"] = 'AE'
      translation_hash["æ"] = 'ae'
      translation_hash
    end

  end

end
