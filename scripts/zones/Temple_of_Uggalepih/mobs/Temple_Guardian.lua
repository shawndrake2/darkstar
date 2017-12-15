-----------------------------------
-- Area: Temple of Uggalepih
--  MOB: Temple Guardian
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
    GetNPCByID(17428978):openDoor(300); -- 5min
end;