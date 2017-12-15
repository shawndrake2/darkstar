-----------------------------------
-- Area: Pso'xja
--  MOB: Gargoyle
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)

    for i = 0, 16, 1 do

    local GargoyleOffset = 16814082 + (i-1);
    local DoorOffset = 16814445 + (i);

        if (mob:getID() == GargoyleOffset) then
            GetNPCByID(DoorOffset):openDoor(30);
        end
    end

end;