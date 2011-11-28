module CarrierWave
	module SecureFile
		module Downloader


			class << self

				def call(uploader_model,activerecord_record)
					downloader = uploader_model.new
					uploaded_file = activerecord_record
					downloader.download!(uploaded_file.user_file.to_s)
					file = downloader.to_s
					ext_file = file + ".x1"
					File.rename(file,ext_file)
					p "Downloader Configuration: "
					configuration = CarrierWave::SecureFile.configuration
					bf = Crypt::Blowfish.new(configuration.cypher)
					bf.decrypt_file(ext_file, file)
					File.unlink(ext_file)
					return { :file => file, :content_type => uploaded_file.content_type }
				end

			end


		end
	end
end