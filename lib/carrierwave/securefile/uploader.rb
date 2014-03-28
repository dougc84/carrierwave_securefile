module CarrierWave
  module SecureFile
    module Uploader
      def self.secure_file(model=nil, file)
        if !model.nil? && model.id.nil?
          Rails.logger.debug "Uploading using #{CarrierWave::SecureFile.cryptable}..."
          ext_file = file + ".x1"
          File.rename(file, ext_file)
          configuration = CarrierWave::SecureFile.configuration
          if configuration.encryption_type.downcase.to_sym == :aes
            aes_key = configuration.aes_key
            if model.aes_key.nil? || model.aes_key == ''
              digest = Digest::SHA256.new
              digest.update(file.to_s)
              model.aes_key = aes_key = digest.to_s
            end
            unless model.pepper.nil?
              aes_key = model.pepper
            end
            encryptor = CarrierWave::SecureFile::AESFileEncrypt.new(aes_key, configuration.aes_iv)
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
