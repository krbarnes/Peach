require 'minitest/autorun'
require 'mocha/minitest'
require 'peach'

class XCTest < Minitest::Test

	def setup
		@runtimes = File.read('test/runtimes.json')
		@device_types = File.read('test/device_types.json')
		XC.any_instance.stubs(:load_runtimes).returns(@runtimes)
		XC.any_instance.stubs(:load_device_types).returns(@device_types)
	end

  def test_runtimes_parsed
  	xc = XC.new
  	assert_equal(6, xc.runtimes.count)
  	name = xc.runtime_name("com.apple.CoreSimulator.SimRuntime.iOS-12-0")
  	assert_equal("iOS 12.0", name)
  end

  def test_device_types_parsed
  	xc = XC.new
  	assert_equal(44, xc.device_types.count)
  	name = xc.device_name("com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus")
  	assert_equal("iPhone 6 Plus", name)
  end
end