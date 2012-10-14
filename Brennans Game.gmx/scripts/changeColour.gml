for(i = 0; i < 4 i +=1)
    {
        red[i]+= (x/(room_width/(i+1) - 0.5) + y/(room_height/(i+1) - 0.5))*argument0*boolToNeg(i)*(xlast*2+ylast*1.5)
        green[i] += (x/(room_width*(i+1)/3 - 0.5) + y/(room_height*(i+1)/3 - 0.5))*argument0*boolToNeg(i)*(xlast+ylast*2)
        blue[i] += (x/(room_width*(i+1) - 0.5) + y/(room_height/(i+1) - 0.5))*argument0*boolToNeg(i)*(xlast*2+ylast*1.5)
        
        //red[i]+= x/room_height*boolToNeg(i)
        //green[i] += 0
        //blue[i] += 0
        
        /*red[i]= abs(red[i]) mod 255
        green[i] =  abs(green[i]) mod 255
        blue[i] =  abs(blue[i]) mod 255*/
        
        color[i] = make_color(sin(red[i])*255/2+255/2,cos(green[i])*255/2+255/2,sin(blue[i])*255/2+255/2)
    }
