#!/usr/bin/env ruby

require 'json'
require 'yaml'

def delete_sim(device)
	puts "Deleting #{device['name']}"
	`xcrun simctl delete #{device['udid']}`
end

def delete_all_sims
	simctl_json = JSON.parse(`xcrun simctl list devices -j`)
	device_list = simctl_json['devices']
	device_list.each do |type, devices|
		devices.each { |device| delete_sim(device) }
	end
end

def available_runtimes
	runtimes_json = JSON.parse(`xcrun simctl list runtimes -j`)
	runtimes = runtimes_json['runtimes']
	runtime_hash = {}
	runtimes.each do |runtime|
		runtime_hash[runtime["name"]] = runtime["identifier"]
	end
	runtime_hash
end

def make_new_sims
	runtimes = available_runtimes()

	device_yml = YAML.load_file('peach.yml')
	puts device_yml
	device_yml.each do |properties|
		runtime = runtimes[properties["runtime"]]
		if runtime
			`xcrun simctl create \"#{properties["name"]}\" \"#{properties["device_type"]}\" \"#{runtime}\"`
		end
	end
end

delete_all_sims
make_new_sims