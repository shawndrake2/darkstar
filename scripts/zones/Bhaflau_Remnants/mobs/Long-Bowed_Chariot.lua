-----------------------------------
-- Area:
--  MOB: Long-Bowed_Chariot
-----------------------------------
require("scripts/globals/titles");
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
    player:addTitle(dsp.title.COMET_CHARIOTEER);
end;