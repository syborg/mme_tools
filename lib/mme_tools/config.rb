# config
# Marcel Massana 11-Sep-2011
#
# A configuration class to tidy up setup of applications
# http://mjijackson.com/2010/02/flexible-ruby-config-objects

require 'yaml'

module MMETools

  #TODO mirar un gem que es diu construct. Fa el mateix. Igual es pot canviar

  # Helps keeping configuration parameters, i.e. of any application, grouped
  # within the same object. Also, it can be saved and restored from a YAML
  # file easing edition of configuration very easily.
  # First of all we should create an MMETools::Config object (see documentation)
  #   config = MMETools::Config.new
  # Configuration parametres could have any name and can be setted by
  # assignation:
  #   config.my_own_param = {:param => 'my own value'}
  # Of course, their values can be of any type if they can be marshaled with
  # yaml.
  # To access those parameters we can use the obvious dot attribute way.
  #   puts config.my_own_param  # => {:param => 'my own value'}
  # but also it is possible to chain dots to access inner hashes, for instance:
  #   puts config.my_own_param.param # => 'my_own_value'
  class Config

    # creates a MMETools::Config object to gracefully keep configuration
    # parameters for any app. if a Hash +data+ is given it is used to populate
    # it.
    #   cfg = MMETools::Config.new(
    #     :param1 => 1,
    #     :param2 => 2
    #   )
    # If a +block+ is passed, it can be used to setup additional data. self is
    # yielded tot tha block. For instance:
    #   cfg = MMETools::Config.new do |c|
    #     c.param1 = 1
    #     c.param2 = 2
    #   end
    # Of course, both idioms can be combined though block is the last to be
    # evaluated, so its actions may overwrite hash created config data.
    def initialize(data={},&block)
      @data = {}
      update!(data)
      yield(self) if block_given?
    end

    # updates kept configuration with +data+ Hash. If a key already exists
    # the corresponding value updates.
    def update!(data)
      # can't be used @data.merge because []= is differently defined (below)
      data.each do |key, value|
        self[key] = value
      end
    end

    alias merge! update!

    # creates a hash from a MMETools::Config object.
    def to_hash
      @data.inject({}) do |ac,(k,v)|
        ac.merge! k => ((v.kind_of? self.class) ? v.to_hash : v)
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

    # loads a hash from YAML file +filename+ and merges its contents
    def load(filename)
      update! YAML.load_file(filename)
    end

    # creates a MMETools::Config object form an already dumped one.
    # +filename+ is the name of the file containing configuration.
    def self.load(filename)
      new.load filename
    end

    # saves configuration into a _yaml_ file named +filename+
    def dump(filename)
      File.open(filename,'w') do |f|
        YAML.dump(self.to_hash,f)
      end
    end

    alias save dump

    private

    def method_missing(sym, *args)
      if sym.to_s =~ /(.+)=$/
        self[$1] = args.first
      else
        self[sym]
      end
    end

  end

end
