# This is a workaround for the lack of support for array, hash, boolean types
# for class parameters in the PE 3.0 console.
# This class wraps ntp, takes a comma-separted string of ntp servers, creates
# an array and passes this array as a parameter to the ntp class.
# It has future support for arrays in the console built in.

class console_ntp(
  # we want to be able to define the server list in the PE console
  $server_list
) {
  # to future-proof this module for when PE Console supports array params
  if is_array($server_list) {
    $server_list_array = $server_list
  # to work around lack of array param support by accepting a comma-separated string of servers
  } elsif is_string($server_list) {
    if strip($server_list) == '' {
      $server_list_array = undef
    } else {
      $server_list_array = split($server_list, ',')
    }
  } else {
    fail("only array or string values are acceptable for server_list parameter")
  }
  # if no valid server list, defer to defaults in ntp
  if $server_list_array == undef {
    include ::ntp
  # otherwise validate, normalize, and pass our array of servers
  } else {
    # strip any whitespace from array elements to normalize
    $normal_server_list_array = strip($server_list_array)
    # deduplicate empty array entries
    $final_server_list_array = delete($normal_server_list_array, '')
    # make sure we ended up with a valid array
    validate_array($final_server_list_array)
    #pass the array of ntp servers to ntp
    class { ::ntp:
      server_list => $final_server_list_array,
    }
  }
}
