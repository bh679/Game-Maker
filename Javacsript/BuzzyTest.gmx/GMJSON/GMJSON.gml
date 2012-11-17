#define setup_JSON
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

#define parse_JSON
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

#define parse_array
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

#define destroy_JSON
/* Syntax: destroy_JSON(JSON_Object)

Arguments:
JSON_Object - The JSON object to destroy

Returns: Nothing

Notes: This frees all memory used by the given JSON object, which also 
       makes the object inaccessible from then on.
       
       Yes, it's a simple function, but consider it an alias for the sake
       of consistency.
*/
with (argument0) { instance_destroy(); }

#define cleanup_JSON
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

#define string_remove_spaces
/* Syntax: string_remove_spaces(str)

Arguments:
str - The string

Returns: The string with all whitespace trimmed from the left.

Notes: This is mainly used internally by the GMJSON system and should not
       be called manually...unless you really want to ;) . It won't hurt
       anything if you play with it a bit :) .
*/
var whitespace,str;
str=argument0;
whitespace=chr(9)+" "+chr(13)+chr(10);

while (string_length(str)>0 && string_pos(string_char_at(str, 1), whitespace)>=1) {
  str=string_delete(str, 1, 1);
}

return str;

#define string_clip_end
/* Syntax: string_clip_end(str)

Arguments:
str - The string

Returns: The string with all whitespace trimmed from the right.

Notes: This is mainly used internally by the GMJSON system and should not
       be called manually...unless you really want to ;) . It won't hurt
       anything if you play with it a bit :) .
*/
var whitespace,str;
str=argument0;
whitespace=chr(9)+" "+chr(13)+chr(10);

while (string_length(str)>0 && string_pos(string_char_at(str, string_length(str)), whitespace)>=1) {
  str=string_delete(str, string_length(str), 1);
}

return str;

