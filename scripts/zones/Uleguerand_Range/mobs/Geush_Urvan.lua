-----------------------------------
-- Area: Uleguerand_Range
--  MOB: Geush Urvan
-- Notes: Spawned from qm1
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
    GetNPCByID(16798097):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME);
end;