require 'socket'

def my_first_private_ipv4
  ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  ip.ip_address if ip
end

def my_first_public_ipv4
  Socket.ip_address_list.detect{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast? and !intf.ipv4_private?}
end
