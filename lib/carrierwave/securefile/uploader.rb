module CarrierWave
	module SecureFile
		module Uploader


			def self.secure_file(model=nil, file)
				if model.id.nil?
					Rails.logger.debug "Uploading using #{CarrierWave::SecureFile.cryptable}..."
					ext_file = file + ".x1"
					File.rename(file, ext_file)
					configuration = CarrierWave::SecureFile.configuration
					if configuration.cypher == AESFile
						encryptor = AESFileEncrypt.new(configuration.aes_key, configuration.aes_iv)
						encryptor.do ext_file, file
					else
						encryptor = CarrierWave::SecureFile.cryptable.new(CarrierWave::SecureFile.cypher)
						encryptor.encrypt_file(ext_file, file)
					end
					File.unlink(ext_file)
					file
				end
			end
			
			
		end
	end
end