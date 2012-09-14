# AES File Encrypton using openssl and aes-256-cbc
# written by Doug Clark - www.dougclarkonline.com
# 
# Usage:
# 
# generate keys:
# keys = AESFileKeygen.new
# key = keys.key
# iv = keys.iv
# 
# encrypt files (after generating keys):
# encryptor = AESFileEncrypt.new(key, iv)
# encryptor.do "file.to.be.encrypted", "encrypted.file.aes"
# 
# decrypt files (after generating keys):
# decryptor = AESFileDecrypt.new(key, iv)
# decryptor.do "file.to.be.decrypted", "decrypted.file"

require 'openssl'

module AESFile
	
	attr_accessor :cipher, :key, :iv, :cipher_type
	
	def init_cipher(the_cipher)
		unless self.cipher
			self.cipher = OpenSSL::Cipher.new(the_cipher)
		end
	end

	def set_cipher_method(the_cipher_method)
		if [:encrypt, :decrypt].include? the_cipher_method.to_sym
			self.cipher.send(the_cipher_method)
		end
	end

	def set_cipher_key(the_cipher_key=nil)
		if self.key
			self.cipher.key = self.key
		elsif the_cipher_key.nil?
			self.cipher.key = self.key = self.cipher.random_key
		else
			self.cipher.key = self.key = the_cipher_key
		end
	end

	def set_cipher_iv(the_cipher_iv=nil)
		if self.iv
			self.cipher.iv = self.iv
		elsif the_cipher_iv.nil?
			self.cipher.iv = self.iv = self.cipher.random_key
		else
			self.cipher.iv = self.iv = the_cipher_iv
		end
	end
	
	def initialize(module_name)
		require module_name
		eval("#{module_name}.init")
	end
	
end

class AESFileKeygen
	
	include AESFile
	
	def initialize
		self.cipher_type = "aes-256-cbc"
		self.cipher = OpenSSL::Cipher.new(self.cipher_type)
		set_cipher_key
		set_cipher_iv
	end
	
end
		

class AESFileEncrypt
	
	include AESFile

	def initialize(key, iv)
		self.cipher_type = 'aes-256-cbc'
		init_cipher self.cipher_type
		set_cipher_method :encrypt
		set_cipher_key key
		set_cipher_iv iv
	end
	
	def do(from_file, to_file)
		
		buf = ""
		File.open(to_file, "wb") do |outf|
			File.open(from_file, "rb") do |inf|
				while inf.read(4096, buf)
					outf << self.cipher.update(buf)
				end
				outf << self.cipher.final
			end
		end
	end
	
end

class AESFileDecrypt
	
	include AESFile

	def initialize(key, iv)
		self.cipher_type = 'aes-256-cbc'
		init_cipher self.cipher_type
		set_cipher_method :decrypt
		set_cipher_key key
		set_cipher_iv iv
	end
	
	def do(from_file, to_file)
		buf = ""
		File.open(to_file, "wb") do |outf|
			File.open(from_file, "rb") do |inf|
				while inf.read(4096, buf)
					outf << self.cipher.update(buf)
				end
				outf << self.cipher.final
			end
		end	
	end
	
end




