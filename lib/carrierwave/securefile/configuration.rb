module CarrierWave
	module SecureFile
		
		def self.configure
			yield configuration
		end
		
		def self.configuration
			@configuration ||= CarrierWave::SecureFile::Configuration.new
		end
		
		class Configuration
			attr_accessor :cypher, :encryption_type
		end
		
		class << self
			
			def cryptable
				configuration = CarrierWave::SecureFile.configuration
				begin
					if configuration.encryption_type.downcase == "blowfish"
						Crypt::Blowfish
					# elsif configuration.encryption_type.downcase == "idea"
					# 	Crypt::IDEA
					elsif configuration.encryption_type.downcase == "rijndael"
						Crypt::Rijndael
					elsif configuration.encryption_type.downcase == "gost"
						Crypt::Gost
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