module CarrierWave
	module SecureFile
		
		def self.configure
			yield configuration
		end
		
		def self.configuration
			@configuration ||= CarrierWave::SecureFile::Configuration.new
		end
		
		class Configuration
			attr_accessor :cypher
		end

	end
end