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
