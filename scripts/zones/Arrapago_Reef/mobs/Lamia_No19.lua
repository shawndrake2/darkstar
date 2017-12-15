-----------------------------------
-- Area: Arrapago Reef
--  MOB: Medusa
-----------------------------------
require("scripts/globals/titles");
-----------------------------------

function onMobSpawn(mob)
end;

function onMobEngaged(mob,target)

    SpawnMob(16998869):updateEnmity(target);
    SpawnMob(16998870):updateEnmity(target);

end;

function onMobDeath(mob, player, isKiller)
end;