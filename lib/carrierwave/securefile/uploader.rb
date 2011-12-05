module CarrierWave
	module SecureFile
		module Uploader


			def self.secure_file(model=nil, file)
				if model
					Rails.logger.debug "Uploading using #{CarrierWave::SecureFile.cryptable}..."
					ext_file = file + ".x1"
					File.rename(file, ext_file)
					configuration = CarrierWave::SecureFile.configuration
					bf = CarrierWave::SecureFile.cryptable.new(configuration.cypher)
					bf.encrypt_file(ext_file, file)
					File.unlink(ext_file)
					file
				end
			end
			
			
		end
	end
end