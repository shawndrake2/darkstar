-----------------------------------
-- Area: Temple Of Uggalepih
--  MOB: Rumble Crawler
-----------------------------------
require("scripts/globals/groundsofvalor");
-----------------------------------

function onMobDeath(mob, player, isKiller)
    checkGoVregime(player,mob,791,2);
end;

function onMobDespawn(mob)
    -- Rumble Crawler that spawns in place of Habetrot
    if(mob:getID() == 17428812) then
        GetNPCByID(17428871):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME);
    end
end;