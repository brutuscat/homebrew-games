require 'formula'

class Mame < Formula
  homepage 'http://mamedev.org/'
  url 'git://git.redump.net/mame', :revision => 'mame0151'
  version '0.151'

  head 'git://git.redump.net/mame'

  def patches
    "https://gist.github.com/brutuscat/8163526/raw/f9d489982385d5869a8b6ba07397e8dcb0818c79/sdl2-patch.diff"
  end
  
  depends_on :x11
  depends_on 'sdl'

  def install
    ENV['MACOSX_USE_LIBSDL'] = '1'
    ENV['INCPATH'] = "-I#{MacOS::X11.include}"
    ENV['PTR64'] = (MacOS.prefer_64_bit? ? '1' : '0')

    system 'make', "CC=#{ENV.cc}", "LD=#{ENV.cxx}",
                   'TARGET=mame', 'SUBTARGET=mame'

    if MacOS.prefer_64_bit?
      bin.install 'mame64' => 'mame'
    else
      bin.install 'mame'
    end
  end
end
