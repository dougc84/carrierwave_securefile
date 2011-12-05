module CarrierWave
	module SecureFile
		module Downloader

			class << self

				def call(uploader_model, activerecord_record, file_field)
					Rails.logger.debug "Downloading using #{CarrierWave::SecureFile.cryptable}..."
					downloader = uploader_model.new
					uploaded_file = activerecord_record
					filename = eval("uploaded_file.#{file_field.to_s}").to_s
					downloader.download!(filename)
					file = downloader.to_s
					ext_file = file + ".x1"
					File.rename(file,ext_file)
					configuration = CarrierWave::SecureFile.configuration
					bf = CarrierWave::SecureFile.cryptable.new(configuration.cypher)
					bf.decrypt_file(ext_file, file)
					File.unlink(ext_file)
					return { :file => file, :content_type => uploaded_file.content_type }
				end
				
			end


		end
	end
end