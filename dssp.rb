require 'formula'

class Dssp < Formula
  homepage 'http://swift.cmbi.ru.nl/gv/dssp/'
  url 'ftp://ftp.cmbi.ru.nl/pub/software/dssp/dssp-2.1.0.tgz'
  sha1 'ac943f49e2bdce73b3523434ec811857e50d82a2'

  depends_on 'boost'

  def install
    # Create a make.config file that contains the configuration for boost
    File.open('make.config', 'w') do |makeconf|  
        makeconf.puts "BOOST_LIB_SUFFIX = -mt"
        makeconf.puts "BOOST_LIB_DIR    = /usr/local/lib"
        makeconf.puts "BOOST_INC_DIR    = /usr/local/include"
     end

    # There is no need for the build to be static and static build causes
    # an error: ld: library not found for -lcrt0.o
    system "sed", "-i", "-e", "s/-static//g", "makefile"

    # The makefile ask for g++ as a compiler but that causes a error at link
    # time: ld: library not found for -lgcc_ext.10.5
    system "make", "install", "DEST_DIR=#{prefix}", "MAN_DIR=#{man}/man1", "CXX=c++"
  end

  test do
    system "false"
  end
end
