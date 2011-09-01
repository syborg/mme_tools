# mme_tools/debug
# Marcel Massana 1-Sep-2011

module MMETools

  # tiny methods for debugging
  module Debug

    # outputs a debug message and details of each of the vars if included.
    # +stck_lvls+ is the number of stack levels to be showed
    # +vars+ is a list of vars to be pretty printed. It is convenient to
    # make the first to be a String with an informative message.
    def print_debug(stck_lvls, *vars)
      @mutex ||= Mutex.new  # instance mutex created the first time it is called
      referers = caller[0..stck_lvls] if stck_lvls >= 0
      @mutex.synchronize do
        referers.each { |r| puts "#{r}:"}
        vars.each { |v| pp v } if vars
      end
    end

  end

end
