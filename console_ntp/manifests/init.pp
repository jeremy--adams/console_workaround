class console_ntp(
  $server_list = '0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org'
) {
  $server_list_array = split($server_list, ',')  

  class { ::ntp: 
    server_list => $server_list_array,
  }
}
    
