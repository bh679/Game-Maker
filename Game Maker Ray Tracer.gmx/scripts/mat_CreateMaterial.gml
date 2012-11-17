//argument0 - diffuse(color)
//argument1 - specular(color)
//argument2 - shininess
//argument3 - reflective(color)
//argument4 - refractive(color)
//argument5 - refractive index
//returns - material ID
{
    global.mat_materials[global.mat_numMaterials, 0] = argument0;
    global.mat_materials[global.mat_numMaterials, 1] = argument1;
    global.mat_materials[global.mat_numMaterials, 2] = argument2;
    global.mat_materials[global.mat_numMaterials, 3] = argument3;
    global.mat_materials[global.mat_numMaterials, 4] = argument4;
    global.mat_materials[global.mat_numMaterials, 5] = argument5;
    global.mat_numMaterials += 1;
    return global.mat_numMaterials - 1;
}