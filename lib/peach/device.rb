require 'plist'

class Device
	attr_reader :name, :device_type, :runtime, :udid

	def initialize(name:, device_type:, runtime:, udid: nil, xc: XC.new)
		@name = name
		@device_type = device_type
		@runtime = runtime
		@udid = udid
		@xc = xc
	end

	def exists?
		Device.current_devices(xc: @xc).include?(self)
	end

	def create
		runtime_id = @xc.runtimes.key(@runtime)
		`xcrun simctl create \"#{@name}\" \"#{@device_type}\" \"#{runtime_id}\"`

		# reload everything to get the device.
		newDevices = Device.current_devices(xc: @xc).select { |d| d == self }
		@udid = newDevices.first.udid
	end

	def destroy
		`xcrun simctl delete #{@udid}`
	end

	alias_method :eql?, :==
	def ==(o)
		o.class == self.class &&
		o.name == @name &&
		o.device_type == @device_type &&
		o.runtime == runtime
	end

	#class functions

	def self.destroy_all(xc:)
		Device.current_devices(xc: xc).each do |d|
			d.destroy
		end
	end

	def self.current_devices(xc:)
		devices = Array.new

		simctl_json = JSON.parse(load_devices)
		device_list = simctl_json['devices']

		device_list.each do |type, ds|
			runtime = xc.runtime_name(type)

			ds.each do |d|
				device_name = d["name"]
				device_udid = d["udid"]
				device_type = device_type(udid: device_udid, xc: xc)
				devices << Device.new(name: device_name, device_type: device_type, runtime: runtime, udid: device_udid, xc: xc)
			end
		end

		devices
	end

	def self.device_type_identifier(udid:, xc:)
		plist = Plist.parse_xml("#{ENV['HOME']}/Library/Developer/CoreSimulator/Devices/#{udid}/device.plist")
		plist["deviceType"]
	end

	def self.device_type(udid:, xc:)
		return xc.device_name(device_type_identifier(udid: udid, xc: xc))
	end

	def self.load_devices
		`xcrun simctl list devices -j`
	end
end