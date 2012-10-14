ball = argument0
_tangent = argument1
difference = _tangent - ballDirection[ball]
   
ballDirection[ball] = _tangent + difference;// + 180

//modulise speed
if ballDirection[ball] mod 360 < 0
   ballDirection[ball] = ballDirection[i] mod 360 + 360

///break down speed
_hspeed = lengthdir_x(ballSpeed[ball],ballDirection[ball])
_vspeed = lengthdir_y(ballSpeed[ball],ballDirection[ball])

//apply speed
ballx[ball] += _hspeed
bally[ball] += _vspeed


