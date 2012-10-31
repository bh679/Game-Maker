//show_message("entered function")
stringval = TestGetJson()
show_message("recived string")
retval = json_decode(stringval)
show_message("decoded")
return retval
