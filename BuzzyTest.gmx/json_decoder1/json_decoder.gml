#define json_init
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
var obj, init_code;


if (variable_global_exists("__json_object"))
{
    if (global.__json_object[3] = true)    return 0;
}

globalvar __json_object;

/*Initialize a json object object*/
obj = object_add();
init_code =
'level = 0;
type = "object";
keyvalues = ds_map_create();';
object_event_add(obj,ev_create,0,init_code);
init_code = /*Clean up code*/
'for (i=ds_map_size(keyvalues); i>0; i-=1)
{
    key = ds_map_find_first(keyvalues);
    obj = ds_map_find_value(keyvalues,key);
    with (obj) instance_destroy(); /*Destroy any instances attached*/
    ds_map_delete(keyvalues,key);
}
ds_map_destroy(keyvalues);';
object_event_add(obj,ev_destroy,0,init_code);
__json_object[0] = obj;




/*Initialize a json array object*/
obj = object_add();

init_code =
'level = 0;
type = "array";
keyvalues = ds_list_create();';
object_event_add(obj,ev_create,0,init_code);
init_code = /*Clean up code*/
'for (i=ds_list_size(keyvalues); i>0; i-=1)
{
    obj = ds_list_find_value(keyvalues,1);
    with (obj) instance_destroy(); /*Destroy any instances attached*/
    ds_list_delete(keyvalues,1);
}
ds_list_destroy(keyvalues);';
object_event_add(obj,ev_destroy,0,init_code);
__json_object[1] = obj;




/*Initialize a json nodevalue object*/
obj = object_add();

init_code =
'level = 0;
type = "nodevalue";
value = "";';
object_event_add(obj,ev_create,0,init_code);
__json_object[2] = obj;

__json_object[3] = true;
return 0;

#define json_finalize
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/* Call to finalize JSON parsing session. Opposite to json_init */
globalvar __json_object;

for (i=0;i<3;i+=1)
{
    with (__json_object[i]) json_destroy(self);
}

for (i=0;i<3;i+=1)
{
    object_delete(__json_object[i]);
}

__json_object[3] = false;


#define json_destroy
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*returns zero on success*/

obj = argument0;

if (obj.level = 0) /*Don't destroy if there are objects pointing to it*/
{
    with (obj) instance_destroy(); /*Should set off a chain reaction automagically destroying allocated resources*/
    return 0;
}

return -1

#define json_get_value
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/*Returns either a pointer a array or object or a value (if the target pointer points to a nodevalue)*/

var obj, key, obj_ptr,force_ptr;
obj = argument0;
key = argument1;
force_ptr = argument2; /*Force the function to return a pointer*/

switch (obj.type)
{
    case "object":
        obj_ptr = ds_map_find_value(obj.keyvalues,key);
        break;
    case "array":
        obj_ptr = ds_list_find_value(obj.keyvalues,real(key));
        break;
    case "nodevalue":
        return obj.value;
    default:
        return -1;
}

if (obj_ptr.type = "nodevalue" && !force_ptr)
{
    return json_get_value(obj_ptr);
}else{
    return obj_ptr;
}

#define json_parse
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var obj,stack,str,i,error;

str = argument0;
stack = ds_stack_create();

json_skip_whitespace(str,1,stack);
i = ds_stack_pop(stack);
error = ds_stack_pop(stack);

if (error != 0)
{
    return -1;
}

switch (json_char_type(str))
{
    case 3:
        obj = json_parse_object(str,i,0,stack);
        break;
    case 4:
        obj = json_parse_array(str,i,0,stack);
        break;
    default:
        return -1;
}

ds_stack_destroy(stack);
return obj;

#define json_object_size
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var obj;
obj = argument0;

switch (obj.type)
{
    case "object":
        return ds_map_size(obj.keyvalues);
    case "array":
        return ds_list_size(obj.keyvalues);
    case "nodevalue":
        return 1;
    default:
        return -1;
}

#define json_parse_object
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
Returns: -1 on failure, object pointer on success

Stack return:
    [0] New string position push'd first
*/
var str,stack,i,error,level,obj,curr_char,inew,param,value,wantout,expect;
str = argument0;
i = real(argument1);
level = real(argument2);
stack = argument3;


json_skip_whitespace(str,i,stack);
i = ds_stack_pop(stack);
error = ds_stack_pop(stack);
if (error = 1)
{
    return -1;
}

if (json_char_type(string_char_at(str,i)) != 3)
{
    return -1;
}
i+=1;

obj = json_new_object("object",level); /*Create an object at current level*/
if (obj = -1)
{
    return -1;
}
curr_char = "";
expect = 0; /*0 = expecting a parameter, 1 = expecting a value*/

wantout = false;
while (curr_char != "}")
{
    json_skip_whitespace(str,i,stack);
    i = ds_stack_pop(stack);
    error = ds_stack_pop(stack);
    if (error = 1)
    {
        with (obj) instance_destroy();
        return -1;
    }
    curr_char = string_char_at(str,i);
    switch (expect)
    {
        case 0: /*Expecting a parameter*/
            switch (json_char_type(curr_char))
            {
                case 1:
                    json_parse_number(str,i,stack);
                    param = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    break;
                case 2:
                    json_parse_string(str,i,stack);
                    param = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    break;
                default:
                    with (obj) instance_destroy();
                    return -1;
                    break;
            }
            json_skip_delimiter(str,i,stack);
            i = ds_stack_pop(stack);
            error = ds_stack_pop(stack);
            if (error != 0)
            {
                with (obj) instance_destroy();
                return -1;
            }
            expect = 1;
            break;
        case 1: /*Expecting a value*/
            switch (json_char_type(curr_char))
            {
                
                case 1:
                    json_parse_number(str,i,stack);
                    value = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    value = json_new_object("nodevalue",level+1,value);
                    break;
                case 2:
                    json_parse_string(str,i,stack);
                    value = ds_stack_pop(stack);
                    i = ds_stack_pop(stack);
                    error = ds_stack_pop(stack);
                    if (error != 0)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    value = json_new_object("nodevalue",level+1,value);
                    break;
                case 3:
                    value = json_parse_object(str,i,level+1,stack);
                    if (value = -1)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    i = ds_stack_pop(stack);
                    break;
                case 4:
                    value = json_parse_array(str,i,level+1,stack);
                    if (value = -1)
                    {
                        with (obj) instance_destroy();
                        return -1;
                    }
                    i = ds_stack_pop(stack);
                    break;
                default:
                    with (obj) instance_destroy();
                    return -1;
                    break;
            }
            json_skip_comma(str,i,stack);
            i = ds_stack_pop(stack);
            error = ds_stack_pop(stack);
            if (error != 0)
            {
                json_skip_whitespace(str,i,stack);
                i = ds_stack_pop(stack);
                error = ds_stack_pop(stack);
                if (error != 0)
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                if (string_char_at(str,i) != "}")
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                wantout = true;
            }
            expect = 0;
            json_add_value(obj,value,param);
            break;
        default:
            with (obj) instance_destroy();
            return -1;
            break;
    }
    
    if (wantout)
    {
        break;
    }
}
ds_stack_push(stack,i+1);
return obj;

#define json_parse_array
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
Returns: -1 on failure, array pointer on success

Stack return:
    [0] New string position push'd first
*/
var str,stack,i,error,level,obj,curr_char;
str = argument0;
i = real(argument1);
level = real(argument2);
stack = argument3;
json_skip_whitespace(str,i,stack);
i = ds_stack_pop(stack);
error = ds_stack_pop(stack);
if (error = 1)
{
    return -1;
}


if (json_char_type(string_char_at(str,i)) != 4)
{
    return -1;
}
i+=1;


obj = json_new_object("array",level); /*Create an object at current level*/
curr_char = "";

while (curr_char != "]")
{
    json_skip_whitespace(str,i,stack);
    i = ds_stack_pop(stack);
    error = ds_stack_pop(stack);
    if (error = 1)
    {
        with (obj) instance_destroy();
        return -1;
    }
    curr_char = string_char_at(str,i);

    switch (json_char_type(curr_char))
    {
        case 1:
                json_parse_number(str,i,stack);
                value = ds_stack_pop(stack);
                i = ds_stack_pop(stack);
                error = ds_stack_pop(stack);
                if (error != 0)
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                value = json_new_object("nodevalue",level+1,value);
                break;
        case 2:
                json_parse_string(str,i,stack);
                value = ds_stack_pop(stack);
                i = ds_stack_pop(stack);
                error = ds_stack_pop(stack);
                if (error != 0)
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                value = json_new_object("nodevalue",level+1,value);
                break;
        case 3:
                value = json_parse_object(str,i,level+1,stack);
                i = ds_stack_pop(stack);
                if (value = -1)
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                break;
        case 4:
                value = json_parse_array(str,i,level+1,stack);
                i = ds_stack_pop(stack);
                if (value = -1)
                {
                    with (obj) instance_destroy();
                    return -1;
                }
                break;
        default:
                with (obj) instance_destroy();
                return -1;
                break;
    }
    
    json_add_value(obj,value);
    json_skip_comma(str,i,stack);
    i = ds_stack_pop(stack);
    error = ds_stack_pop(stack);
    if (error != 0)
    {
        json_skip_whitespace(str,i,stack);
        i = ds_stack_pop(stack);
        error = ds_stack_pop(stack);
        if (error != 0)
        {
            with (obj) instance_destroy();
            return -1;
        }
        if (string_char_at(str,i) != "]")
        {
            with (obj) instance_destroy();
            return -1;
        }
        break;
    }

}

ds_stack_push(stack,i+1); /*Skip over ]*/
return obj;
    


#define json_parse_string
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
Returns:
    [0] = String                    push'd 3rd
    [1] = New string position       push'd 2nd
    [2] = Error (0 means no error)  push'd 1st

Error:
    2 = Unknown character
    3 = End of string
*/
var str,stack,i,error,rtn_str,escape_mode,curr_char;
str = argument0;
i = real(argument1);
stack = argument2;

json_skip_whitespace(str,i,stack) /*Skip whitespace to be sure*/
i = ds_stack_pop(stack); /*New string position*/
error = ds_stack_pop(stack);
if (error = 1)
{
    ds_stack_push(stack,3);
    ds_stack_push(stack,i);
    ds_stack_push(stack,"");
    return 0;
}
rtn_str = "";

escape_mode = false;


if (string_char_at(str,i) != '"')
{
    ds_stack_push(stack,2);
    ds_stack_push(stack,i);
    ds_stack_push(stack,"");
    return 0;
}

i+=1; /*Increment past the quotation mark*/

while (1)
{
    if (i > string_length(str))
    {
        ds_stack_push(stack,3); /*Unexpected end of string*/
        ds_stack_push(stack,i);
        ds_stack_push(stack,"");
        return 0;
    }
    curr_char = string_char_at(str,i);
    if (curr_char = '"' && !escape_mode) /*Check for quotation mark*/
    {
        /*Finished parsing*/
        ds_stack_push(stack,0);
        ds_stack_push(stack,i+1); /*Add one to go past the quotation mark*/
        ds_stack_push(stack,rtn_str);
        return 0;
    }
    
    if (escape_mode) /*Unescape if in escape mode*/
    {
        switch curr_char
        {
        case '"':
            rtn_str += '"';
            break;
        case "\":
            rtn_str += "\";
            break;
        case "b":
            rtn_str += chr(8);
            break;
        case "t":
            rtn_str += chr(9);
            break;
        case "n":
            rtn_str += chr(10);
            break;
        case "f":
            rtn_str += chr(12);
            break;
        case "r":
            rtn_str += chr(13);
            break;
        default:
            rtn_str += "\"+curr_char;
            break;
        }
        escape_mode = false; /*Not in escape mode any more*/
    }else{
    /*Otherwise, process as normal*/
        switch curr_char
        {
        case "\":
            escape_mode = true;
            break;
        default:
            rtn_str += curr_char;
        }
    }
    i+=1;
}

#define json_parse_number
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
Returns:
    [0] = Number                    push'd 3rd
    [1] = New string position       push'd 2nd
    [2] = Error (0 means no error)  push'd 1st

Error:
    1 = unknown character
    
    3 = end of string
*/
var str,stack,i,error,rtn,curr_char,powerof,temp;

str = string(argument0);
i = real(argument1);
stack = argument2;

json_skip_whitespace(str,i,stack) /*Skip whitespace to be sure*/
i = ds_stack_pop(stack); /*New string position*/
error = ds_stack_pop(stack);
if (error = 1)
{
    ds_stack_push(stack,3);
    ds_stack_push(stack,i);
    ds_stack_push(stack,0);
    return 0;
}
rtn = "";

if (json_char_type(string_char_at(str,i)) != 1)
{
    ds_stack_push(stack,1);
    ds_stack_push(stack,i);
    ds_stack_push(stack,0);
    return 0;
}

powerof = false;
temp = "";
while (1)
{
    curr_char = string_lower(string_char_at(str,i));
    
    if (json_char_type(curr_char)) != 1 || (i > string_length(str))
    {
        break;
    }
    if (curr_char = "e" && !powerof)
    {
        powerof = true;
        temp = rtn;
        rtn = "";
    }else{
        rtn += curr_char;
    }
    i=i+1
}

if (powerof)
{
    rtn = real(temp) * power(10, real(rtn));
}

ds_stack_push(stack,0);
ds_stack_push(stack,i);
ds_stack_push(stack,real(rtn));

return 0;
    

#define json_skip_whitespace
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
    Return:
    [0] = New string position       push'd 2nd
    [1] = Error (0 means no error)  push'd 1st
    
    Error:
    0 = none
    1 = end of string
*/
var str,str_pos,stack;
str = argument0;
str_pos = real(argument1);
stack = argument2;
while (json_char_type(string_char_at(str,str_pos)) = 0)
{
    str_pos+=1;
    if (str_pos > string_length(str))
    {
        ds_stack_push(stack, 1);
        ds_stack_push(stack, str_pos-1);
        return 0;
    }
    
}
ds_stack_push(stack, 0);
ds_stack_push(stack, str_pos);

return 0;

#define json_char_type
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/* Returns current character type

Returns:
    -1 = wtf
    0  = whitespace
    1  = number
    2  = string
    3  = object
    4  = array (unimplemented)
    5  = comma
    6  = delimiter
*/

var str,char;
str = string(argument0);

char = string_char_at(str,1);

switch char /*Get basics out the way*/
{
    case " ":
        return 0;
    case '"':
        return 2;
    case "{":
        return 3;
    case "[":
        return 4;
    case ",":
        return 5;
    case ":":
        return 6;
}

numbers = "0123456789.e-+";

if (string_count(char,numbers))
{
    return 1;
}

return -1;


#define json_skip_delimiter
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
    Return:
    [0] = New string position       push'd 2nd
    [1] = Error (0 means no error)  push'd 1st
    
    Error:
    0 = none
    1 = end of string
    2 = unknown character
*/
var str,str_pos,stack,error;
str = argument0;
str_pos = real(argument1);
stack = argument2;

json_skip_whitespace(str,str_pos,stack);
str_pos = ds_stack_pop(stack);
error = ds_stack_pop(stack);
if (error != 0)
{
    ds_stack_push(stack, error);
    ds_stack_push(stack, str_pos);
    return 0;
}

if (json_char_type(string_char_at(str,str_pos)) != 6)
{
    ds_stack_push(stack, 2);
    ds_stack_push(stack, str_pos);
    return 0;
}

ds_stack_push(stack, 0);
ds_stack_push(stack, str_pos+1);
return 0;

#define json_skip_comma
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*
    Return:
    [0] = New string position       push'd 2nd
    [1] = Error (0 means no error)  push'd 1st
    
    Error:
    0 = none
    1 = end of string
    2 = unknown character
*/
var str,str_pos,stack,error;
str = argument0;
str_pos = real(argument1);
stack = argument2;
json_skip_whitespace(str,str_pos,stack);
str_pos = ds_stack_pop(stack);
error = ds_stack_pop(stack);
if (error != 0)
{
    ds_stack_push(stack, error);
    ds_stack_push(stack, str_pos);
    return 0;
}

if (json_char_type(string_char_at(str,str_pos)) != 5)
{
    ds_stack_push(stack, 2);
    ds_stack_push(stack, str_pos);
    return 0;
}

ds_stack_push(stack, 0);
ds_stack_push(stack, str_pos+1);

return 0;

#define json_new_object
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
/*Returns -1 on failure*/
globalvar __json_object;

if (!variable_global_exists("__json_object"))
{
    if (global.__json_object[3] = true)    return -1;
}

var obj,type,level,value;
globalvar __json_object;
type = argument0;
level = real(argument1);
value = argument2; /*Only used for nodevalue*/

switch (type)
{
    case "object":
        obj = instance_create(-1,-1,__json_object[0]);
        obj.level = level;
        return obj;
    case "array":
        obj = instance_create(-1,-1,__json_object[1]);
        obj.level = level;
        return obj;
    case "nodevalue":
        obj = instance_create(-1,-1,__json_object[2]);
        obj.level = level;
        json_add_value(obj,value);
        return obj;
    default:
        return -1;
}

#define json_add_value
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var obj, value, key;
obj = argument0;
value = argument1; /*Unless assigning to a nodevalue, this MUST be a object pointer*/
key = argument2; /*Only used for objects*/


switch (obj.type)
{
    case "object":
        ds_map_add(obj.keyvalues,key,value);
        return 0;
    case "array":
        ds_list_add(obj.keyvalues,value);
        return 0;
    case "nodevalue":
        obj.value = value;
        return 0;
    default:
        return -1;
}

#define json_dump
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/*Pushes: new y value*/

var obj,str,i,addspace,orig_addspace;

obj = argument0;
addspace = string(argument1);

if (addspace = "0")
{
    addspace = "";
}

//str=addspace+"Dumping object \#"+string(obj)+"#";
str="";

switch (obj.type)
{
    case "object":
        curr_key = json_get_first_key(obj);
        for (i=0; i< json_object_size(obj);i+=1)
        {
            str+=addspace+"Key:       "+string_replace(json_escape(string(curr_key)),"#","\#")+"#";
            str+=addspace+"Value:     \#"+string_replace(json_escape(string(json_get_value(obj,curr_key,true))),"#","\#")+"#";
            str+=json_dump(json_get_value(obj,curr_key,true),addspace+"  ");
            curr_key = json_get_next_key(obj,curr_key);
        }
        break;
    case "array":
        for (i=0; i< json_object_size(obj);i+=1)
        {
            str+=addspace+"Key:       "+string(i)+"#";
            str+=addspace+"Value:     \#"+string_replace(json_escape(string(json_get_value(obj,i,true))),"#","\#")+"#";
            str+=json_dump(json_get_value(obj,i,true),addspace+"  ");
        }
        break;
    case "nodevalue":
        str+=addspace+'Value:     '+string_replace(json_escape(string(json_get_value(obj))),"#","\#")+"#";
        break;
}
//str+=orig_addspace+"Dump End \#"+string(obj)+"#";
return str;

#define json_get_first_key
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var obj;

obj = argument0;

if (obj.type != "object")   return -1;

return ds_map_find_first(obj.keyvalues);

#define json_get_next_key
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var obj;

obj = argument0;
key = argument1;

if (obj.type != "object")   return -1;

return ds_map_find_next(obj.keyvalues,key);

#define json_escape
/*
Copyright (c) 2010, Daniel Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var str;

str = string(argument0);
str = string_replace_all(str ,'\','\\'); /*Escape backslashes (Must be first or it'll screw everything)*/

str = string_replace_all(str ,'"','\"'); /*Escape double quotes*/
str = string_replace_all(str ,chr(8) ,'\b'); /*Escape control character backspace*/
str = string_replace_all(str ,chr(9) ,'\t'); /*Escape control character horizontal tab*/
str = string_replace_all(str ,chr(10),'\n'); /*Escape control character linefeed*/
str = string_replace_all(str ,chr(12),'\f'); /*Escape control character formfeed*/
str = string_replace_all(str ,chr(13),'\r'); /*Escape control character carriage return*/


return str;

