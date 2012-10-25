#define gmdlg_wait_open
{ /* This function displays a progress dialog box. Useful for loading stuff
in between levels. After calling this function, use gmdlg_wait_change to
change the length of the progress bar and caption.
gmdlg_wait_open()
*/
return external_call(global._gmdlg_wait_show,window_get_width()-5,44);
}
#define gmdlg_wait_change
{ /* This script will change the Please Wait dialog box
gmdlg_wait_change(percent,caption)
percent: A real number 0-100. For example 50 will make the bar go half way
caption: The caption to change it to.
RETURNS: True if the data was changed, false if not
*/
return external_call(global._gmdlg_wait_change,argument0,argument1);
}
#define gmdlg_wait_isopen
{ /* This script returns true if the Please Wait box is open, false if not.
gmdlg_wait_isopen()
*/
return external_call(global._gmdlg_wait_isopen);
}
#define gmdlg_wait_close
{ /* This script closes the already open Please Wait box.
gmdlg_wait_close()
RETURNS: True if it was closed, false if not.
*/
return external_call(global._gmdlg_wait_close);
}
#define gmdlg_terms_show
{ /* This script displays a Terms of Use/EULA/Agreement/Liscense Agreement
dialog box. As soon as this function returns, the user has closed the dialog
box. It will return true if the user agreed, or false if the user did not.
gmdlg_terms_show(terms,checkbox,capt)
terms: the terms of use to show. Use the # character to go to a new line,
\# to get the character by itself.
checkbox: The text to the right of the check box. Should be something like
"I agree with the terms above".
capt: The caption of the dialog box.
*/
var str;
str=argument0;
str=string_replace_all(str,"#",chr(13)+chr(10));
str=string_replace_all(str,"\"+chr(13)+chr(10),"#");
return external_call(global._gmdlg_terms_show,str,argument1,argument2);
}
#define gmdlg_quickhelp_open
{ /* Displays/changes the Quick Start/Quick Help window
gmdlg_quickstart(text,caption)
text: the text to display. Use the # character to go to a new line.
\# to get the character by itself.
caption: the text to display in the caption
RETURNS: 1 if the dialog box was created, 0 if it was still there and the
contents have been updated with the new information
*/
var str;
str=argument0;
str=string_replace_all(str,"#",chr(13)+chr(10));
str=string_replace_all(str,"\"+chr(13)+chr(10),"#");
return external_call(global._gmdlg_quickhelp_open,str,argument1,argument2);
}
#define gmdlg_quickhelp_close
{ /* This script closes the Quick Help/Quick Start window
gmdlg_quickhelp_close()
NOTE: This function only works if the dialog box is open!
RETURNS: 1 if removed, 0 if it couldn't be removed
*/
return external_call(global._gmdlg_quickhelp_close);
}
#define gmdlg_quickhelp_isopen
{ /* Returns true if the Quick Start/Quick Help dialog box is open,
false if not.
gmdlg_quickhelp_isopen()
*/
return external_call(global._gmdlg_quickhelp_isopen);
}
#define gmdlg_quickhelp_sethelp
{ /* This function defines what file should be opened when the
"Show Full Help" button is clicked in the Quick Help/Quick Start dialog box.
gmdlg_quickhelp_sethelp(filename)
filename: the file to open
NOTE: If you don't want to have a file open when it is clicked, don't call
this function in the first place (or call it again and pass an empty string)
and the "Show Full Help" button will be disabled.
RETURNS: 0
*/
external_call(global._gmdlg_quickhelp_sethelp,argument0);
}
#define gmdlg_quickhelp_seticon
{ /*Changes the icon of the Quick Start/Quick Help window to teh specified icon
file/program.
gmdlg_quickhelp_seticon(icon)
icon: Can be an ico file or an exe. To use the icon of your game in the window,
pass parameter_string(0) (not a string).
*/
return external_call(global._gmdlg_quickhelp_seticon,argument0);
}
#define gmdlg_calendar_set
{ /* Before you call gmdlg_calendar_show, you can optionally call this script
to set the default date and time for the calendar and time picker.
gmdlg_calendar_set(year,month,day,hour,minute,second)
See gmdlg_calendar_get to find out the ranges for each argument.
If you don't call this script, the default date and time used will be the
current one.
*/
external_call(global._gmdlg_calendar_set,argument0,argument1,argument2,argument3,argument4,argument5);
}
#define gmdlg_calendar_show
{ /* This script displays a dialog box with a calendar and a time picker
gmdlg_calendar_show(caption,text,icon,disable)
caption: the text of the caption of the dialog box
text: the text inside the dialog box (use # for newline)
icon: An icon file/exe that contains the icon to put beside the caption
disable: Disables the calendar and/or time picker control. Chart below:
# | What it disables
--------------------------------------------------
0 | Nothing is disabled
1 | Time picker is disabled
2 | Calendar is disabled
3 | Both the calendar and time picker are disabled
RETURNS: true if the user clicked OK, false if not.
*/
var str;
str=argument1;
str=string_replace_all(str,"#",chr(13)+chr(10));
str=string_replace_all(str,"\"+chr(13)+chr(10),"#");
return external_call(global._gmdlg_calendar_show,argument0,str,argument2,argument3)
}
#define gmdlg_calendar_get
{ /* This script will return the date and time information as selected by the
user in the calendar dialog box.
gmdlg_calendar_get(what_to_get)
what_to_get should be:
# | What the function returns
------------------------------------------------
0 | Year (1753-9999)
1 | Month (1-12)
2 | Day of Week (1=Sunday,2=Monday...7=Saturday) 
3 | Day of the Month (1-31)
4 | Hour (1-24)
5 | Minute (0-59)
6 | Second (0-59)
NOTE: This function only returns accurate data IF gmdlg_calendar_show
returns true (which means the user clicked OK, not Cancel)
*/
external_call(global._gmdlg_calendar_get,argument0);
}
#define gmdlg_listitems_show
{ /* Opens the List Items dialog box. You should first fill it with items using
gmdlg_listitems_add before calling this script.
gmdlg_listitems_show(text,caption,icon,multiselect)
text: The text to show at the top. Use # for newline.
caption: The caption of the dialog box
icon: the icon to display beside the caption
multiselect: should be 1 if you want to permit users the ability to select
multiple items in the list box. 2 if you want the select all/unselect all
buttons disabled. 0 if you only want only one item to be chosen.
RETURNS: true if the user clicked OK, false if not. Only if the user clicks OK
the DLL remembers what they selected, which can later be discovered using the
gmdlg_listitems_selected script.
*/
var str;
str=argument0;
str=string_replace_all(str,"#",chr(13)+chr(10));
str=string_replace_all(str,"\"+chr(13)+chr(10),"#");
external_call(global._gmdlg_listitems_show,str,argument1,argument2,argument3);
}
#define gmdlg_listitems_add
{ /* Adds items to the List Items dialog box. You can add a maximum of 1024
strings to this dialog box.
gmdlg_listitems_add(str,sel)
str: The string to add
sel: should be true if you want the string to be selected by default, false if
not.
RETURNS: true if the string could be added, false if the limit has been hit.
*/
external_call(global._gmdlg_listitems_add,argument0,argument1);
}
#define gmdlg_listitems_selected
{ /* Tells you which item(s) were selected by the user, after
gmdlg_listitems_show returns true.
gmdlg_listitems_selected()
RETURNS: The ID of the string selected. If the list is a single selection list,
call this function once to find out the id of the string selected. If nothing
was selected, this script will return -1.
If it is a multiple selection list, call this function again and again. It will
return each ID one after the other. As soon as it returns -1, the end as been
reached.
WHAT THIS ID NUMBER FOR EACH STRING IS: The first string will have the ID 0,
the second one will have a 1, the third one will have a 2, and so on.
*/
return external_call(global._gmdlg_listitems_selected);
}
#define gmdlg_auth_show
{ /* This script displays a dialog box that allows the user to enter a
username and password.
gmdlg_auth_show(text,caption,disable)
text: the text to display in the dialog box
caption: what the caption text should be
disable: Disables some fields for you. Here's a chart:
# | What it disables
0 | Nothing is disabled
1 | Password field is disabled
2 | Username field is disabled
3 | Both the username and password fields are disabled.
*/
var str;
str=argument0;
str=string_replace_all(str,"#",chr(13)+chr(10));
str=string_replace_all(str,"\"+chr(13)+chr(10),"#");
return external_call(global._gmdlg_auth_show,str,argument1,argument2);
}
#define gmdlg_auth_icon
{ /* Changes icon settings in the authorization dialog box. Call this script
before calling gmdlg_auth_show.
gmdlg_auth_icon(icon,displaydlgicon)
icon: the filename of the icon to display to the left of the caption text
displaydlgicon: should be true if you want an additional icon displayed
inside the dialog box beside the main text, otherwise setting this argument
to false makes the icon dissapear.
*/
external_call(global._gmdlg_auth_icon,argument0,argument1);
}
#define gmdlg_auth_setstr
{ /* Sets some strings in the dialog box.
gmdlg_auth_setstr(id,str1,str2)
Based on what argument id may be, str1 and str2 change some strings in the
dialog box. Here's a chart describing this:
# | Description                  | str1        | str2
0 | Changes the group box text   | Information | Authorization
1 | Default text for the fields  | Username    | Password
2 | Username and password labels | Username    | Password
If you feel this wasn't described clearly enough, just try experimenting with
this function first, and then I'm sure you'll figure out what it does.
*/
external_call(global._gmdlg_auth_setstr,argument0,argument1,argument2)
}
#define gmdlg_auth_getinfo
{ /* Returns the username or password entered into the authorization dialog
box. These strings are available only after calling gmdlg_auth_show.
gmdlg_auth_getinfo(vartoget)
vartoget: if it is 0, this function will return the username entered. If it is
1, this function returns the password entered.
*/
return external_call(global._gmdlg_auth_getinfo,argument0);
}
#define gmdlg_track_show
{ /* Displays a dialog box that lets the user choose a number from a range of
numbers, by dragging a track bar, entering a percentage point, or entering a
positive integer. These three methods of input are linked together in this
dialog box, meaning that if you change the value of one, the rest will adjust
themselves.
gmdlg_track_show(max,default,trackbardisabled,trackbarlines,otherdisabled)
max: the maximum value the user can choose. The minimum is always 0.
default: the default number. should be >0 and <max.
trackbardisabled: should be true if you want the track bar to be disabled.
trackbarlines: how frequent the track bar lines should be. 0 for none.
otherdisabled: other controls which should be disabled. Here's a chart:
# | What it disables
0 | Nothing is disabled
1 | Percentage box is disabled
2 | Integer box is disabled
3 | Both the percentage and integer boxes are disabled
RETURNS: true if the user clicks OK, false if not. If this function does
return true, call gmdlg_track_num() to find out the number the user gave.
The rest of the parameters for this dialog box can be set with gmdlg_track_set
*/
return external_call(global._gmdlg_track_show,argument0,argument1,argument2,argument3,argument4);
}
#define gmdlg_track_set
{ /* Sets the strings displayed in the Track Bar dialog box
gmdlg_track_set(caption,text,integer_label,percent_label)
caption: the caption of the dialog box
text: the text to display in the dialog box
integer_label: the text to display beside the integer field
percent_label: the text to display beside the percentage field
*/
var str;
str=argument1;
str=string_replace_all(str,"#",chr(13)+chr(10));
str=string_replace_all(str,"\"+chr(13)+chr(10),"#");
if(argument2=="") { argument2="Value:"; }
if(argument3=="") { argument3="Percentage:"; }
external_call(global._gmdlg_track_set,argument0,str,argument2,argument3)
}
#define gmdlg_track_num
{ /* Returns the number selected in the track bar dialog box */
return external_call(global._gmdlg_track_num);
}
#define gmdlg_track_icon
{ /* Sets the icon in the track bar dialog box.
gmdlg_track_icon(icon)
icon: can be an ico file, or an exe containing the icon
*/
external_call(global._gmdlg_track_icon,argument0);
}
#define gmdlg_init
{
//Call this script once before any of the other functions!
//returns: true if the DLL was found, false if not.

var dll;
dll="gmdlg32.dll";
if(!file_exists(dll)) {
 show_message("The Game Maker Common Dialog Box DLL ("+dll+") was not found.");
 return 0;
 }
//quickhelp/quickstart
global._gmdlg_quickhelp_open=external_define(dll,"quickstart",dll_stdcall,ty_real,3,ty_string,ty_string,ty_string);
global._gmdlg_quickhelp_sethelp=external_define(dll,"qstart_sethelp",dll_stdcall,ty_real,1,ty_string);
global._gmdlg_quickhelp_close=external_define(dll,"qstart_close",dll_stdcall,ty_real,0);
global._gmdlg_quickhelp_isopen=external_define(dll,"qstart_on",dll_stdcall,ty_real,0);
global._gmdlg_quickhelp_seticon=external_define(dll,"qstart_seticon",dll_stdcall,ty_real,1,ty_string);
//terms
global._gmdlg_terms_show=external_define(dll,"terms_show",dll_stdcall,ty_real,3,ty_string,ty_string,ty_string);
//wait
global._gmdlg_wait_show=external_define(dll,"wait_show",dll_stdcall,ty_real,2,ty_real,ty_real);
global._gmdlg_wait_change=external_define(dll,"wait_change",dll_stdcall,ty_real,2,ty_real,ty_string);
global._gmdlg_wait_isopen=external_define(dll,"wait_isopen",dll_stdcall,ty_real,0);
global._gmdlg_wait_close=external_define(dll,"wait_close",dll_stdcall,ty_real,0);
//calendar
global._gmdlg_calendar_show=external_define(dll,"cal_show",dll_stdcall,ty_real,4,ty_string,ty_string,ty_string,ty_real);
global._gmdlg_calendar_set=external_define(dll,"cal_sdt",dll_stdcall,ty_real,6,ty_real,ty_real,ty_real,ty_real,ty_real,ty_real);
global._gmdlg_calendar_get=external_define(dll,"cal_get",dll_stdcall,ty_real,1,ty_real);
//list items
global._gmdlg_listitems_show=external_define(dll,"listbox_open",dll_stdcall,ty_real,4,ty_string,ty_string,ty_string,ty_real);
global._gmdlg_listitems_add=external_define(dll,"listbox_add",dll_stdcall,ty_real,2,ty_string,ty_real);
global._gmdlg_listitems_selected=external_define(dll,"listbox_sel",dll_stdcall,ty_real,0);
//auth
global._gmdlg_auth_show=external_define(dll,"authbox_open",dll_stdcall,ty_real,3,ty_string,ty_string,ty_real);
global._gmdlg_auth_icon=external_define(dll,"authbox_ico",dll_stdcall,ty_real,2,ty_string,ty_real);
global._gmdlg_auth_setstr=external_define(dll,"authbox_setstr",dll_stdcall,ty_real,3,ty_real,ty_string,ty_string);
global._gmdlg_auth_getinfo=external_define(dll,"authbox_getinfo",dll_stdcall,ty_string,1,ty_real);
//track bar
global._gmdlg_track_show=external_define(dll,"track_open",dll_stdcall,ty_real,5,ty_real,ty_real,ty_real,ty_real,ty_real);
global._gmdlg_track_set=external_define(dll,"track_setstrs",dll_stdcall,ty_real,4,ty_string,ty_string,ty_string,ty_string);
global._gmdlg_track_num=external_define(dll,"track_getnum",dll_stdcall,ty_real,0);
global._gmdlg_track_icon=external_define(dll,"track_setico",dll_stdcall,ty_real,1,ty_string);

var hwnd;
hwnd=external_define(dll,"sethwnd",dll_stdcall,ty_real,1,ty_real);
external_call(hwnd,window_handle());
return 1;
}
