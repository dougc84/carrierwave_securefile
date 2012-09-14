module CarrierWave
	module SecureFile
		module Downloader

			class << self

				def call(uploader_model, activerecord_record, file_field)
					Rails.logger.debug "Downloading using #{CarrierWave::SecureFile.cryptable}..."
					file = nil
					downloader = uploader_model.new
					uploaded_file = activerecord_record
					filename = eval("uploaded_file.#{file_field.to_s}").to_s
					begin
						downloader.download!(filename)
						file = downloader.file.path.to_s
					rescue Exception => e
						Rails.logger.debug "Unable to download file: #{e}"
					end
					
					if File.exists? file
						ext_file = file + ".x1"
						File.rename(file,ext_file)
						configuration = CarrierWave::SecureFile.configuration
						if configuration.encryption_type.downcase.to_sym == :aes
							aes_key = configuration.aes_key
							if activerecord_record.respond_to? :aes_key
								aes_key = activerecord_record.aes_key
							end
							bf = CarrierWave::SecureFile::AESFileDecrypt.new(aes_key, configuration.aes_iv)
							bf.do ext_file, file
						else
							bf = CarrierWave::SecureFile.cryptable.new(configuration.cypher)
							bf.decrypt_file ext_file, file
						end
						File.unlink ext_file
						return { :file => file, :content_type => uploaded_file.content_type }
          else 
            # return nil if no file was found
            Rails.logger.debug "Unable to find the target file."
            nil
        	end
				end		

			end
		end
	end
end