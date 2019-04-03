class Device
	def initialize(name, device_type, runtime, udid=nil)
		@name = name
		@device_type = device_type
		@runtime = runtime
		@udid = udid
	end

	def name
		@name
	end

	def device_type
		@device_type
	end

	def runtime
		@runtime
	end

	def udid
		return @udid
	end

	def exists?
		return !!@udid
	end

	def create
	end

	def delete
	end
end