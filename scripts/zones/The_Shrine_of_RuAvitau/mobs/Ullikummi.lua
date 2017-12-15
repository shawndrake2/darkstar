-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  MOB: Ullikummi
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
end;

function onMobDespawn(mob)
    GetNPCByID(17506694):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME);
end;