# print_debug_demo
# Marcel Massana 2-Sep-2011
#
# for those printf driven developers, print_debug outputs the context (the
# calling stack upto the number of levels required) and pretty prints the
# following args.

require 'mme_tools/debug'

class A

  include MMETools::Debug

  def method_1
    a=File.new __FILE__
    b=Dir.new File.dirname(__FILE__)
    l=__LINE__
    print_debug 1,"These are vars a, b and l in method_1", a,b,l
    self.method_2
  end

  def method_2
    a=Struct.new(:name, :email).new("Me","me@me.com")
    print_debug 2,"This is var a in method 2", a
    self.method_3
  end

  def method_3
    print_debug 3,"In method 3, following 3 levels of stack, I'll show you (my)self and (my) class", self, self.class
  end

end

A.new.method_1