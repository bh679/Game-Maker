/* Syntax: setup_JSON()

Arguments:
(NONE)

Returns: Nothing

Notes: Call this only once before using GMJSON, or after you've called
       cleanup_JSON() if you want to use GMJSON again.
*/
global.__jsonObject=object_add();

object_event_add(global.__jsonObject, ev_destroy, 0, "
for (p=0; p<ds_list_size(__myChildren121); p+=1) {
  with (ds_list_find_value(__myChildren121, p)) {
    instance_destroy();
  }
}
for (p=0; p<ds_list_size(__myLists121); p+=1) {
  ds_list_destroy(ds_list_find_value(__myLists121, p))
}
ds_list_destroy(__myChildren121);
ds_list_destroy(__myLists121);
");

/* To ensure no internal list has ID=0, which would make it impossible
   to tell when a list was supplied to a function or not, we make one
   now to hold at LEAST spot 0 */
global.__useless=ds_list_create(); 
