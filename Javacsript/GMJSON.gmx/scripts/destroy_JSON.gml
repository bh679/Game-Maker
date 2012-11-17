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
