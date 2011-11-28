require 'digest/md5'
# require 'carrierwave/securefile.rb'
require 'carrierwave/securefile/uploader.rb'
require 'carrierwave/securefile/downloader.rb'
require 'carrierwave/securefile/configuration.rb'

unless defined? Crypt
	begin
		require 'crypt/blowfish'
	rescue LoadError
		puts "WARNING: Failed to require crypt/blowfish, encryption may fail!"
		puts "         You may need to add the crypt19 gem."
	end
end

module CarrierWave
end