# mme_tools/enumerable
# Marcel Massana 1-Sep-2011

module MMETools

  # Methods for Enumerables (Arrays and other each-equiped stuff)
  module Enumerable

    # torna un array on cada element es una tupla formada per
    # un element de cada enumerable. Si se li passa un bloc
    # se li passa al bloc cada tupla i el resultat del bloc
    # s'emmagatzema a l'array tornat.
    def compose(*enumerables)
      res=[]
      enumerables.map(&:size).max.times do
        tupla=[]
        for enumerable in enumerables
          tupla << enumerable.shift
        end
        res << (block_given? ? yield(tupla) : tupla)
      end
      res
    end

    # Interessant iterador que classifica un enumerable
    # (The Ruby Way , Ed. 2 - p 289)
    def classify(enumrbl, &block)
      hash = {}
      enumrbl.each do |el|
        res = block.call el # tb res=yield(el)
        hash[res] = [] unless hash.has_key? res
        hash[res] << el
      end
      hash
    end

    # FIXME I on't know really why I designed this ... possibly drop candidate
    # returns an array containing from +first+ to +last+
    # options is a hash that can contain:
    # +:comp=>eq_method+ is a a symbol with the name of the method that sent to
    #     an element with another element as parameter evaluates equality. If not
    #     supplied +:==+ assumed.
    # +:max=>max_num+ is the maximum size of the returned array. If not supplied
    #     false assumed (no limit)
    # +:last_included?=>true or false+ tells if +last+ should be included.
    #     If not included +true+ assumed
    # The code block is not optional: it is passed an element and should return
    # the next.
    def from_to(first, last, options=nil)
      if options && options.is_a?(Hash)
        maxcount = options.has_key?(:max) ? options[:max] : false
        lastincluded = options.has_key?(:last_included?) ? options[:last_included?] : true
      else
        maxcount = false
        lastincluded = true
      end
      ret = [first]
      count = 1
      while true
        first = yield(first)
        if first == last or (maxcount ? (count > maxcount) : false)
          ret << first if lastincluded
          break
        end
        ret << first
      end
      ret
    end

    # torna un array amb els elements parells
    # mes a http://stackoverflow.com/questions/1614147/odd-or-even-entries-in-a-ruby-array
    def odd_values(array)
      array.values_at(* array.each_index.select {|i| i.odd?})
      # array.select_with_index{|item, i| item if i % 2 == 1}
    end

    # torna un array amb els elements senars
    # mes a http://stackoverflow.com/questions/1614147/odd-or-even-entries-in-a-ruby-array
    def even_values(array)
      array.values_at(* array.each_index.select {|i| i.even?})
      # array.select_with_index{|item, i| item if i % 2 == 1}
    end

  end

end
