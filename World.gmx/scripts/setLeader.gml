var ID;
ID = id
leader = false
isLeader = false
_other.leader = false
_other.isLeader = false

if argument0 = false
{
    ID = _other
    leader = ID
}
else
    _other.leader = ID

    
if ID.clan = -1
    ID.clan = round(random(CLANS)) mod CLANS

obj_clan.leader[ID.clan] = ID
ID.isLeader = true
ID.leader = false

