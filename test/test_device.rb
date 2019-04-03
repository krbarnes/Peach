require 'minitest/autorun'
require 'peach'

class DeviceTest < Minitest::Test

	def setup
		# Nuke everything, for real
		@xc = XC.new
  	Device.destroy_all(xc: @xc)

  	# Create 2 devices so the system is in a good state.
		@device1 = Device.new(name: "🍑👌", device_type: "iPhone 7", runtime: "iOS 12.2")
  	@device1.create

  	@device2 = Device.new(name: "🍑👌🍑", device_type: "iPhone 8", runtime: "iOS 12.0")
  	@device2.create
	end

	def test_current_devices
		devices = Device.current_devices(xc: @xc)
		assert_equal(2, devices.count)
	end

	def test_device_type
		name = Device.device_type(udid: @device1.udid, xc: @xc)
		assert_equal("iPhone 7", name)
	end

	def test_equality
		d1 = Device.new(name:"new", device_type: "bogus", runtime: "yes", udid: nil)
		d2 = Device.new(name:"new", device_type: "bogus", runtime: "yes", udid: "this is real")
		assert_equal d1, d2
		d2 = Device.new(name:"newish", device_type: "bogus", runtime: "yes", udid: "this is real")
		refute_equal d1, d2
		d2 = Device.new(name:"new", device_type: "real i swear", runtime: "yes", udid: "this is real")
		refute_equal d1, d2
		d2 = Device.new(name:"new", device_type: "bogus", runtime: "noe", udid: "this is real")
		refute_equal d1, d2
	end

	def test_exists
		d1 = Device.new(name:"new", device_type: "bogus", runtime: "yes", udid: nil)
		refute d1.exists?
		d1 = Device.new(name:"new", device_type: "bogus", runtime: "yes", udid: "bogus_udid")
		refute d1.exists?

		devices = Device.current_devices(xc: @xc)
		assert devices.first.exists?
	end

end