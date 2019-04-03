require 'plist'

class Device
	attr_reader :name, :device_type, :runtime, :udid

	def initialize(name:, device_type:, runtime:, udid: nil)
		@name = name
		@device_type = device_type
		@runtime = runtime
		@udid = udid
	end

	def exists?
		return !!@udid
	end

	def create
	end

	def delete
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
				devices << Device.new(name: device_name, device_type: device_type, runtime: runtime, udid: device_udid)
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