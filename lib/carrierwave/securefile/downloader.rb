module CarrierWave
  module SecureFile
    module Downloader
      class << self
        def call(uploader_instance)
          Rails.logger.debug "Downloading using #{CarrierWave::SecureFile.cryptable}..."
          uploader_instance = uploader_instance.clone
          begin
            uploader_instance.cache_stored_file!
            @file = uploader_instance.to_s
          rescue Exception => e
            Rails.logger.debug "Unable to download/copy file: #{e}"
          end
          unless File.exists? @file.to_s
            Rails.logger.debug "Unable to find the target file."
            return nil
          end
          ext_file = @file + ".x1"
          File.rename @file, ext_file
          configuration = CarrierWave::SecureFile.configuration
          if configuration.encryption_type.downcase.to_sym == :aes
            aes_key = uploader_instance.model.aes_key rescue configuration.aes_key
            bf      = CarrierWave::SecureFile::AESFileDecrypt.new(aes_key, configuration.aes_iv)
            bf.do ext_file, @file
          else
            bf = CarrierWave::SecureFile.cryptable.new(configuration.cypher)
            bf.decrypt_file ext_file, @file
          end
          File.unlink ext_file
          { :file => @file, :content_type => uploader_instance.file.content_type }
        end
      end
    end
  end
end
