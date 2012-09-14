module CarrierWave
	module SecureFile
		
		def self.configure
			yield configuration
		end
		
		def self.configuration
			@configuration ||= CarrierWave::SecureFile::Configuration.new
		end
		
		class Configuration
			attr_accessor :cypher, :encryption_type, :aes_iv, :aes_key
		end
		
		class << self
			
			def cypher
				configuration = CarrierWave::SecureFile.configuration
				configuration.cypher[0..55]
			end
			
			def cryptable
				configuration = CarrierWave::SecureFile.configuration
				begin
					case configuration.encryption_type.downcase.to_sym
					when :blowfish
						Crypt::Blowfish
					when :rijndael
						Crypt::Rijndael
					when :gost
						Crypt::Gost
					when :aes
						AESFile
					else
						Crypt::Blowfish
					end
				rescue
					Crypt::Blowfish
				end
			end
			
		end

	end
end