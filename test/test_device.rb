require 'minitest/autorun'
require 'peach'

class DeviceTest < Minitest::Test

	def setup
		@device_list = File.read('test/devices.json')
		@runtimes = File.read('test/runtimes.json')
		@device_types = File.read('test/device_types.json')
		XC.any_instance.stubs(:load_runtimes).returns(@runtimes)
		XC.any_instance.stubs(:load_device_types).returns(@device_types)
		@xc = XC.new
		Device.stubs(:load_devices).returns(@device_list)
	end

	def test_current_devices
		devices = Device.current_devices(xc: @xc)
		assert_equal(4, devices.count)
	end

	def test_device_type
		name = Device.device_type(udid: "D2385B33-B4AB-421E-BE0D-7511CEF66DFC", xc: @xc)
		assert_equal("iPhone 7", name)
	end

  # def test_device_created_and_deleted
    # device = Device.new("test iphone", "iphone x", "ios 12.0")
    # refute device.exists?
    # device.create
    # assert device.exists?
    # device.delete
    # assert_false
  # end

end