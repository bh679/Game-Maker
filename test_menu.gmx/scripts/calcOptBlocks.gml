var blocks, targetdis;
blocks = 0
for(i = 0; i < targets; i += 1)
    targetdis[i] = 0
repeat(2)
{
    for(i = 0; i < targets; i += 1)
    {
        shortestDis = point_blockdistance_3d(0,0,0,targetx[i]*blocksize,targety[i]*blocksize,targetz[i]*blocksize)
        for(s = 0; s < targets; s += 1)
        {
            if targetdis[s] > 0
            {
                sdis = 
                    ceil(point_blockdistance_3d(targetx[s]*blocksize,targety[s]*blocksize,targetz[s]*blocksize,
                    targetx[i]*blocksize,targety[i]*blocksize,targetz[i]*blocksize))
                if shortestDis = 0 || shortestDis > sdis
                    shortestDis = sdis
            }
        }
        targetdis[i] = ceil((shortestDis+1/2)/blocksize)
        //show_message(string(blocks))
    }
}
for(i = 0; i < targets; i += 1)
    blocks += targetdis[i]
return blocks;
