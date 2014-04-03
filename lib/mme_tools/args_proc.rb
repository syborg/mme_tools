# NamedArgs
# Marcel Massana 13-Sep-2011
#
# Extends Hash with methods based on ideas from
# http://saaientist.blogspot.com/2007/11/named-arguments-in-ruby.html
# Also thanks to ActiveSupport from Rails

module MMETools

  extend self

  module ArgsProc

    # Tests if +options+ includes only valid keys. Raises an error if
    # any key is not included within +valid_options+.
    # +valid_options+ is a Hash that must include all accepted keys. values
    # aren't taken into account.
    def assert_valid_keys(options, valid_options)
      unknown_keys = options.keys - valid_options.keys
      raise(ArgumentError, "Unknown options(s): #{unknown_keys.join(", ")}") unless unknown_keys.empty?
    end


  end

end
