# encoding: utf-8
# mme_tools/webparse
# Marcel Massana 1-Sep-2011

require 'rubygems'
require 'iconv'
require 'unicode'
require 'jcode' if RUBY_VERSION < '1.9'
require 'date'

# $KCODE = "u"

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
    # Les opcions +opts+ poden ser:
    #   +:encoding+ => "ASCII" | "UTF8" (default)
    #     "ASCII" converteix tots els caracters al mes semblant ASCII (amb Iconv)
    #     "UTF8" torna una cadena UTF8
    # (based on an idea of Obie Fernandez http://www.jroller.com/obie/tags/unicode)
    def clear_string(str, opts={})
      options = {:encoding=>'UTF8'}.merge opts  # default option :encoding=>'UTF8'
      str=str.chars.map { |c| (c.bytes[0] <= 127) ? c : translation_hash[c] }.join if options[:encoding]=='ASCII'
      str.gsub(/[\s\302\240]+/mu," ").strip # el caracter UTF8 "\302\240" correspon al &nbsp; de HTML
    end
    ## La versio original basada en Iconv no funciona en algunes circumstancies
    #    def orig_clear_string(str, options={:encoding=>'UTF8'})
    #      str=Iconv.conv('ASCII//TRANSLIT//IGNORE', 'UTF8', str) if options[:encoding]=='ASCII'
    #      str.gsub(/[\s\302\240]+/mu," ").strip # el caracter UTF8 "\302\240" correspon al &nbsp; de HTML
    #    end

    # Intenta convertir +str+ a ASCII pur i dur
    def asciify(str)
      Iconv.conv('ASCII//TRANSLIT//IGNORE', 'UTF8', str)
    end
		
    # Transforms a string +str+ to an acronym
    def acronymize(str)
      cleared_str = clear_string(str, :encoding => 'ASCII').gsub(/\W/," ")

      # opcio 1
      unwanted_words_pttrn = %w[de en].map {|w| "\\b#{w}\\b"}.join("|")
      res = cleared_str.gsub(/\b\w\b|#{unwanted_words_pttrn}/i," ")
      res = res.split(" ").map {|s| s[0..0].upcase}.join
    
      # opcio 2
      if res == ""
        res = cleared_str.split(" ").map {|s| s[0..0].upcase}.join
      end
      res
    end
	
    # Transforms +str+ to a shortened version:
    # strips all non-alphanumeric chars, non-ascii and spaces and joins every word
    # first two letters capitalized
    def shorten(str)
      cleared_str = clear_string(str, :encoding => 'ASCII').gsub(/\W/," ")
      cleared_str.split(" ").map {|s| s[0..1].capitalize}.join
    end
	
    # Extracts and returns the first provable DateTime from a string
    def datify(str)
      pttrn = /(\d+)[\/-](\d+)[\/-](\d+)(\W+(\d+)\:(\d+))?/
      day, month, year, dummy, hour, min = str.match(pttrn).captures.map {|d| d ? d.to_i : 0 }
      case year
      when 0..69
        year += 2000
      when 70..99
        year += 1900
      end
      DateTime.civil year, month, day, hour, min
    end
	
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
