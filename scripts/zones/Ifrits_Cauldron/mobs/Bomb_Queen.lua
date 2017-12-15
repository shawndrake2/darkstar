-----------------------------------
-- Area: Ifrit's Cauldron
--  MOB: Bomb Queen
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
    GetNPCByID(17617180):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME);
end;