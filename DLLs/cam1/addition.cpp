//Addition Dev-C++ DLL Example
/* Replace "dll.h" with the name of your header */
#include "adll.h"
#include <windows.h>

extern "C" __declspec(dllexport) __stdcall double addition(double arg1, double arg2);

extern "C" __declspec(dllexport) __stdcall double addition(double arg1, double arg2)
{
    return arg1+arg2;
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
