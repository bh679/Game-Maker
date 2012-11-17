/* Syntax: parse_array(JSON_String)

Arguments:
JSON_String - The string containing the JSON to parse

Returns: A ds_list ID, or a negative error code. See Notes for more information.
         
Notes: This will attempt to parse JSON code contained within a JSON array
       and return a representative ds_list. If parsing fails, a negative
       number will be returned instead, with the following code meanings:
       
       -1: The JSON code is not contained in an array. All JSON arrays must
           be contained in []. If you contain your JSON in an object instead,
           you should use parse_JSON(). This error may also mean that due to
           some quirk in your string, GMJSON tried to parse an object where
           there was none. Check for both of these possibilities.
           
       -2: According to JSON standards, all object member variable names
           must be encapsulated in double-quotes ("). Anything else--including
           single-quotes--is invalid JSON. A variable name without correct
           double-quote encasulation will trigger this error.
           
       -3: There are mismatched quotes somewhere in your JSON string. This
           means you've opened quotes somewhere but never closed them.
           
       -4: A variable name was found in an object, but it was not followed
           by a colon. Every object variable must have a value; if you do
           not supply a value using the "variable":value syntax, this error
           will occur.
           
       -5: The array has ended unexpectedly, usually meaning you've got
           mismatched brackets [] somewhere.
           
       -6: You've given an entry an invalid real value. This may be caused
           by forgetting to enclose string values with double-quotes or also
           by simply supplying an invalid number, like 300t.
           
*/
var ret, str, p, val, temp, parent;

ret=ds_list_create();
parent=argument2;

str=string_remove_spaces(argument0);

/* Must start with a [ */
if (string_char_at(str, 1)!="[") {
  ds_list_destroy(ret);
  return -1;
}
str=string_delete(str, 1, 1);
str=string_remove_spaces(str);

/* Parse variables/members */
while (string_pos(",", str)>=1 || string_pos("]", str)>=1) {

    /* Break when reaching the corresponding ] */
  if (string_char_at(str, 1)=="]") { break; }

  str=string_remove_spaces(str);
  
  /* Parse the value */
  if (string_char_at(str, 1)=='"') {
    /* String values */
    str=string_delete(str, 1, 1);
    if (string_pos('"', str)<=0) {
      ds_list_destroy(ret);
      return -3;
    }
    val=string_copy(str, 1, string_pos('"', str)-1);
    str=string_delete(str, 1, string_pos('"', str));
  }
  else if (string_char_at(str, 1)=="[") {
    /* Arrays */
    temp=ds_list_create();
    val=parse_array(str, temp, parent);
    str=ds_list_find_value(temp, 0);
    ds_list_destroy(temp);
    if (val<0) {
      ds_list_destroy(ret);
      return val;
    } // Error out if recursion fails
  }
  else if (string_char_at(str, 1)=="{") {
    /* Nested objects */
    temp=ds_list_create();
    val=parse_JSON(str, temp);
    str=ds_list_find_value(temp, 0);
    ds_list_destroy(temp);
    if (val<0) {
      ds_list_destroy(ret);
      return val;
    } // Error out if recursion fails
    ds_list_add(parent.__myChildren121, val);
  }
  else if (string_copy(str, 1, 4)=="null") {
    /* Null values */
    str=string_delete(str, 1, 4);
    val=0;
  }
  else if (string_copy(str, 1, 4)=="true") {
    /* Constant true values */
    str=string_delete(str, 1, 4);
    val=true;
  }
  else if (string_copy(str, 1, 5)=="false") {
    /* Constant false values */
    str=string_delete(str, 1, 5);
    val=false;
  }
  else if (string_pos(",", str)<=0 || (string_pos("]",str)>0 && string_pos("]", str)<string_pos(",",str))) {
    /* Last real values */
    if (string_pos("]", str)<=0) { return -5; }
    else {
      val=string_copy(str, 1, string_pos("]", str)-1);
      str=string_delete(str, 1, string_pos("]", str)-1);
      val=string_clip_end(val);
      if (string_digits(val)!=string_replace_all(val, ".", "")) {
        ds_list_destroy(ret);
        return -6;
      }
      val=real(val);
    }
  }
  else {
    /* Middle real values */
    val=string_copy(str, 1, string_pos(",", str)-1);
    str=string_delete(str, 1, string_pos(",", str));
    val=string_clip_end(val);
    if (string_digits(val)!=string_replace_all(val, ".", "")) {
      ds_list_destroy(ret);
      return -6;
    }
    val=real(val);
  }
  str=string_remove_spaces(str);
  
  /* Clear commas */
  if (string_char_at(str, 1)==",") {
    str=string_delete(str, 1, 1);
    str=string_remove_spaces(str);  
  }
  
  ds_list_add(ret, val);
}

if (string_char_at(str, 1)=="]") { str=string_delete(str, 1, 1); }
if (string_char_at(str, 1)==",") { str=string_delete(str, 1, 1); }

if (argument1>0) { ds_list_add(argument1, str); }

return ret;
