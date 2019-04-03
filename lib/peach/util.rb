require 'json'

class Util
	def self.devices
		devices = []
		runtimes = runtimes()

		simctl_json = JSON.parse(device_list)
		device_list = simctl_json['devices']

		device_list.each do |type, devices|
			runtime = runtimes[d.type]

			devices.each do |d|
				device = Device.new(d.name, runtime, )
			end
		end
	end

	def self.fetch_devices
		`xcrun simctl list devices -j`
	end


end