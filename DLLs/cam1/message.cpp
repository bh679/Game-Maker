//Message Dev-C++ DLL Example
/* Replace "dll.h" with the name of your header */
#include "mdll.h"
#include <windows.h>

LPSTR result = "Return this"; //Just a dummy return string

extern "C" __declspec(dllexport) __stdcall LPSTR message(LPSTR title, LPSTR text);

extern "C" __declspec(dllexport) __stdcall LPSTR message(LPSTR title, LPSTR text)
{
    MessageBox(NULL,text,title,MB_OK);
    return result; //It has to return something or else it won't work
};

DllClass::DllClass()
{
}

DllClass::~DllClass ()
{
}

BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ )
{
    switch (reason)
    {
      case DLL_PROCESS_ATTACH:
        break;

      case DLL_PROCESS_DETACH:
        break;

      case DLL_THREAD_ATTACH:
        break;

      case DLL_THREAD_DETACH:
        break;
    }

    /* Returns TRUE on success, FALSE on failure */
    return TRUE;
}
