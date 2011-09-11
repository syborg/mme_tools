# it's only a version number

module MMETools

  module Version

    MAJOR = 0
    MINOR = 0
    PATCH = 2
    BUILD = nil  # use nil if not used
	
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")

  end

end
