/* Syntax: parse_JSON(JSON_String)

Arguments:
JSON_String - The string containing the JSON to parse

Returns: An instance of a JSON object , or a negative error code. See Notes
         for more information.
         
Notes: This will attempt to parse JSON code and return a working JSON object.
       If parsing fails, a negative number will be returned instead, with the
       following code meanings:
       
       -1: The JSON code is not contained in an object. All JSON must be
           contained in {}. If you contain your JSON object in an array
           instead, you should use parse_array(). This error may also
           mean that due to some quirk in your string, GMJSON tried to
           parse an array where there was none. Check for both of these
           possibilities.
           
       -2: According to JSON standards, all member variable names must be
           encapsulated in double-quotes ("). Anything else--including
           single-quotes--is invalid JSON. A variable name without correct
           double-quote encasulation will trigger this error.
           
       -3: There are mismatched quotes somewhere in your JSON string. This
           means you've opened quotes somewhere but never closed them.
           
       -4: A variable name was found, but it was not followed by a colon.
           Every variable must have a value; if you do not supply a value
           using the "variable":value syntax, this error will occur.
           
       -5: The object has ended unexpectedly, usually meaning you've got
           mismatched curly braces {} somewhere.
           
       -6: You've given a variable an invalid real value. This may be caused
           by forgetting to enclose string values with double-quotes or also
           by simply supplying an invalid number, like "distance":300t.
           
*/
var ret, str, p, vari, val, temp;

ret=instance_create(0, 0, global.__jsonObject);

ret.__myLists121=ds_list_create();
ret.__myChildren121=ds_list_create();

str=string_remove_spaces(argument0);

/* Must start with a { */
if (string_char_at(str, 1)!="{") {
  with (ret) { instance_destroy(); }
  return -1;
}
str=string_delete(str, 1, 1);
str=string_remove_spaces(str);

/* Parse variables/members */
while (string_pos(",", str)>=1 || string_pos("}", str)>=1) {

    /* Break when reaching the corresponding } */
  if (string_char_at(str, 1)=="}") { break; }

  /* Every variable name is in quotes */
  if (string_char_at(str, 1)!='"') {
    with (ret) { instance_destroy(); }
    return -2;
  }
  str=string_delete(str, 1, 1);
  
  /* Make sure no mismatched quotes */
  if (string_pos('"', str)<=0) {
    with (ret) { instance_destroy(); }
    return -3;
  }
  vari=string_copy(str, 1, string_pos('"', str)-1);
  str=string_delete(str, 1, string_pos('"', str));
  str=string_remove_spaces(str);
  
  /* And of course, every variable name is followed by a colon */
  if (string_char_at(str, 1)!=":") {
    with (ret) { instance_destroy(); }
    return -4;
  }
  str=string_delete(str, 1, 1);
  str=string_remove_spaces(str);
  
  /* Then the value */
  if (string_char_at(str, 1)=='"') {
    /* String values */
    str=string_delete(str, 1, 1);
    if (string_pos('"', str)<=0) {
      with (ret) { instance_destroy(); }
      return -3;
    }
    val=string_copy(str, 1, string_pos('"', str)-1);
    str=string_delete(str, 1, string_pos('"', str));
  }
  else if (string_char_at(str, 1)=="[") {
    /* Arrays */
    temp=ds_list_create();
    val=parse_array(str, temp, ret);
    str=ds_list_find_value(temp, 0);
    ds_list_destroy(temp);
    if (val<0) {
      with (ret) { instance_destroy(); }
      return val;
    } // Error out if recursion fails
    ds_list_add(ret.__myLists121, val);
  }
  else if (string_char_at(str, 1)=="{") {
    /* Nested objects */
    temp=ds_list_create();
    val=parse_JSON(str, temp);
    str=ds_list_find_value(temp, 0);
    ds_list_destroy(temp);
    if (val<0) {
      with (ret) { instance_destroy(); }
      return val;
    } // Error out if recursion fails
    ds_list_add(ret.__myChildren121, val);
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
  else if (string_pos(",", str)<=0 || (string_pos("}",str)>0 && string_pos("}", str)<string_pos(",",str))) {
    /* Last real values */
    if (string_pos("}", str)<=0) {
      with (ret) { instance_destroy(); }
      return -5;
    }
    else {
      val=string_copy(str, 1, string_pos("}", str)-1);
      str=string_delete(str, 1, string_pos("}", str)-1);
      val=string_clip_end(val);
      if (string_digits(val)!=string_replace_all(val, ".", "")) {
        with (ret) { instance_destroy(); }
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
      with (ret) { instance_destroy(); }
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
  
  with (ret) {
    variable_local_set(vari, val);
  }
}

if (string_char_at(str, 1)=="}") { str=string_delete(str, 1, 1); }
if (string_char_at(str, 1)==",") { str=string_delete(str, 1, 1); }

if (argument1>0) { ds_list_add(argument1, str); }

return ret;
