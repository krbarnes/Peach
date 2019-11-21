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
  	assert_equal(5, xc.runtimes.count)
  	name = xc.runtime_name("com.apple.CoreSimulator.SimRuntime.iOS-12-0")
  	assert_equal("iOS 12.0", name)
  end

  def test_device_types_parsed
  	xc = XC.new
  	assert_equal(3, xc.device_types.count)
  	name = xc.device_name("com.apple.CoreSimulator.SimDeviceType.iPhone-4s")
  	assert_equal("iPhone 4s", name)
  end

  def test_invalid_runtime_is_invalid
    xc = XC.new
    assert xc.runtime_invalid("notaruntime")
    refute xc.runtime_invalid("iOS 12.0")
  end

  def test_invalid_device_type_is_invalid
    xc = XC.new
    assert xc.device_type_invalid("Android")
    refute xc.device_type_invalid("iPhone 4s")
  end
end