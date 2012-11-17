var i, I;
I = argument0
i = I mod 500
retString = string(floor(I/500));
if i > 42
{
    c = 0
    for(n = 0; n < I/500; n+=1)
    for(c = 0; c < i/(122-48); c += 1)
        retString += chr((i/(10^c) + n) mod (122-48) + 48)
    return retString
}
else
    return chr(i mod (122-48))
