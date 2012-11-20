object1 = argument0
object2 = argument1


if object1 = noone
   return object2
   
if object2 = noone
   return object1
   
if (d3d_point_distance(obj_camera.xfrom,obj_camera.yfrom,obj_camera.zfrom,object1.x,object1.y,object1.z)) < (d3d_point_distance(obj_camera.xfrom,obj_camera.yfrom,obj_camera.zfrom,object2.x,object2.y,object2.z))
   return object1
return object2
