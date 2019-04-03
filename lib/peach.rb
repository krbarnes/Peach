#!/usr/bin/env ruby

require 'json'
require 'yaml'
require 'peach/device'
require 'peach/xc'

class Peach

	def self.destroy_all
		Device.destroy_all(xc: XC.new)
	end

	def self.createDevices(peachFile = 'peach.yml')
		peaches = YAML.load_file(peachFile)
		peaches.each do |properties|
			peach_name = properties["name"]
			peach_device = properties["device_type"]
			peach_runtime = properties["runtime"]
			peach = Device.new(name: peach_name, device_type: peach_device, runtime: peach_runtime)
			peach.create() unless peach.exists?
		end
	end
end
