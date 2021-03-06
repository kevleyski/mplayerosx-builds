begin
  require 'plist'
rescue LoadError
  puts 'To use the mplayer bundler you must install the plist gem:'
  puts 'gem install plist'
  exit
end
require 'packager'
require 'dylibpackager'

class MPOSXBinPgkr < Packager

  def plist(options = {})
    options[:name] ||= "mplayer2"
    options[:description] ||= "MPlayer2 binary compiled with libav and libass. Available only for x86_64 platforms."
    options[:maintainer] ||= "Stefano Pigozzi"
    options[:homepage] ||= "http://github.com/pigoz/mplayerosx-builds"
    options[:identifier] ||= "com.google.code.mplayerosx-builds.git"
    options[:svn] ||= "35000"
    options[:time] ||= Time.now

    options[:appcast] ||= nil
    options[:dsa_key] ||= nil

    r = {
      :CFBundleName => options[:name],
      :MPEBinaryDescription => options[:description],
      :MPEBinaryMaintainer => options[:maintainer],
      :MPEBinaryHomepage => options[:homepage],
      :MPEBinarySVNRevisionEquivalent => options[:svn].to_s,
      :CFBundleVersion => options[:time].to_ver,
      :CFBundleShortVersionString => options[:time].to_ver('-'),
      :CFBundleIdentifier => options[:identifier],
      :CFBundleExecutable => mplayer,
      :CFBundleInfoDictionaryVersion => "6.0",
      :LSBackgroundOnly => true
    }
    r[:SUFeedURL] = options[:appcast] if options[:appcast]
    r[:SUPublicDSAKeyFile] = options[:dsa_key] if options[:dsa_key]

    r.to_plist
  end

end
