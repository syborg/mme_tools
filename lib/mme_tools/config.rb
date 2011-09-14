# config
# Marcel Massana 11-Sep-2011
#
# A configuration class to tidy up setup of applications
# http://mjijackson.com/2010/02/flexible-ruby-config-objects

require 'yaml'

module MMETools

  #TODO mirar un gem que es diu construct. Fa el mateix. Igual es pot canviar
  class Config

    def initialize(data={})
      @data = {}
      update!(data)
    end

    def update!(data)
      data.each do |key, value|
        self[key] = value
      end
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      if value.class == Hash
        @data[key.to_sym] = Config.new(value)
      else
        @data[key.to_sym] = value
      end
    end

    def load(filename)
      update! YAML.load_file(filename)
    end

    def dump(filename)
      File.open(filename,'w') do |f|
        YAML.dump(self,f)
      end
    end

    def method_missing(sym, *args)
      if sym.to_s =~ /(.+)=$/
        self[$1] = args.first
      else
        self[sym]
      end
    end

  end

end
