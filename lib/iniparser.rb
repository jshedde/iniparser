# encoding: utf-8


require 'pp'

# our own code
require 'iniparser/version'   # note: let version always go first
require 'iniparser/parser'



module INI

  # returns a nested hash
  #  (compatible structure - works like YAML.load_file)

  def self.load_file( path  )   IniParser::IniParser.load_file( path );  end
  def self.load( text )         IniParser::IniParser.load( text );       end

end  # module INI



# say hello
puts IniParser.banner    if defined?( $RUBYLIBS_DEBUG )
