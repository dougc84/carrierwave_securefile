require 'digest/md5'
require 'logger'
# require 'carrierwave/securefile.rb'
require 'carrierwave/securefile/uploader.rb'
require 'carrierwave/securefile/downloader.rb'
require 'carrierwave/securefile/configuration.rb'

begin # require aes
	require 'carrierwave/securefile/aes_file.rb'
rescue LoadError
	puts "WARNING: Failed to require aes_file or openssl, AES encryption may fail!"
end

begin # require blowfish
	require 'crypt/blowfish'
rescue LoadError
	puts "WARNING: Failed to require crypt/blowfish, encryption may fail!"
	puts "         You may need to add the crypt19 gem."
end

begin # require gost
	require 'crypt/gost'
rescue LoadError
	puts "WARNING: Failed to require crypt/gost, encryption may fail!"
	puts "         You may need to add the crypt19 gem."
end

begin # require rijndael
	require 'crypt/rijndael'
rescue LoadError
	puts "WARNING: Failed to require crypt/rijndael, encryption may fail!"
	puts "         You may need to add the crypt19 gem."
end

module CarrierWave
end