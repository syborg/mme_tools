# it's only a version number

module MMETools

  module Version

    MAJOR = 0
    MINOR = 0
    PATCH = 0
    BUILD = 'pre2'  # use nil if not used
	
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")

  end

end
