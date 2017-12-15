-----------------------------------
-- Area: Xarcabard
--  MOB: Chaos Elemental
-- Spawned for Quest: The Three Magi
-- !pos -335.245 -26.403 -49.190 112
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
    GetNPCByID(17236279):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME);
end;