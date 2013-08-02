# This is a workaround for the lack of support for array, hash, boolean types
# for class parameters in the PE 3.0 console.
# This class wraps ntp, takes a comma-separted string of ntp servers, creates
# an array and passes this array as a parameter to the ntp class.
# It has future support for arrays in the console built in.
 
class console_ntp(
  $server_list = undef
) {
  if $server_list == undef {
    $server_list_array = [
      '0.pool.ntp.org',
      '1.pool.ntp.org',
      '2.pool.ntp.org',
      '3.pool.ntp.org',
    ]
  } else {
    $server_list_array = split($server_list, ',')  
  }
  class { ::ntp: 
    server_list => $server_list_array,
  }
}
    
