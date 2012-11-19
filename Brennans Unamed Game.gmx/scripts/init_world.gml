noOfObjcets = 100

repeat(noOfObjcets)
{
    tree = instance_create(0,0,obj_notfood)
    tree.level = 2
    tree.angle = random(180) + 90
}

