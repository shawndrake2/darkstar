-----------------------------------
-- Area: Upper Delkfutt's Tower
--  MOB: Alkyoneus
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
    GetNPCByID(17424518):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME);
end;