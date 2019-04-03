class XC
	attr_reader :runtimes, :device_types

	def initialize
		@runtimes = init_runtimes
		@device_types = init_device_types
	end

	def runtime_name(identifier)
		return @runtimes[identifier]
	end

	def device_name(identifier)
		return @device_types[identifier]
	end

	def init_runtimes
		runtimes_json = JSON.parse(load_runtimes())
		runtimes = runtimes_json['runtimes']
		runtime_hash = {}
		runtimes.each do |runtime|
			runtime_hash[runtime["identifier"]] = runtime["name"]
		end
		runtime_hash
	end

	def init_device_types
		devicetypes_json = JSON.parse(load_device_types())
		devicetypes = devicetypes_json['devicetypes']
		devicetype_hash = {}
		devicetypes.each do |runtime|
			devicetype_hash[runtime["identifier"]] = runtime["name"]
		end
		devicetype_hash
	end

	def load_runtimes
		`xcrun simctl list runtimes -j`
	end

	def load_device_types
		`xcrun simctl list devicetypes -j`
	end
end