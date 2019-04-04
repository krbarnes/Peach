require 'minitest/autorun'
require 'peach'

class DeviceIntegrationTest < Minitest::Test

  def test_device_created_and_deleted
    xc = XC.new
    # destroy all to make sure env is clean
    Device.destroy_all(xc: xc)
    device = Device.new(name: "👌🍑👌", device_type: "iPhone 7", runtime: "iOS 12.2", xc: xc)
    refute device.exists?
    device.create
    assert device.exists?
    device.destroy
    refute device.exists?
  end

  def test_destroy_all
  	xc = XC.new
  	# create one so that I can assert something is deleted
  	device = Device.new(name: "🍑👌🍑", device_type: "iPhone 7", runtime: "iOS 12.2", xc: xc)
  	device.create
  	refute_empty Device.current_devices(xc: xc)

  	Device.destroy_all(xc: xc)
  	assert_empty Device.current_devices(xc: xc)
  end
end