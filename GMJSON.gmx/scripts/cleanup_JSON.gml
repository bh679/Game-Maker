/* Syntax: cleanup_JSON()

Arguments:
(NONE)

Returns: Nothing

Notes: Call this if you don't need to use GMJSON again. This will essentially
       be done for you on Game End, but if you finish using GMJSON before then,
       this function will clear all memory used by all JSON objects and deinitialize
       the GMJSON system.
       
       Note that if you call this, you cannot use GMJSON again unless you call
       setup_JSON() again.
*/
ds_list_destroy(global.__useless);
with (global.__jsonObject) { instance_destroy(); }
object_delete(global.__jsonObject);
