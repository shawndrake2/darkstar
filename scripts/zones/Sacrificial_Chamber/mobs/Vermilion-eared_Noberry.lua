-----------------------------------
-- Area: Sacrificial Chamber
--  MOB: Vermilion-eared_Noberry
-- BCNM: Jungle Boogymen
-----------------------------------

function onMobSpawn(mob)
end;

function onMobEngaged(mob,target)
end;

function onMobDeath(mob, player, isKiller)
    local elemental = mob:getID()+2;
    local kills = player:getVar("EVERYONES_GRUDGE_KILLS");

    if (kills < 480) then
        player:setVar("EVERYONES_GRUDGE_KILLS",kills + 1);
    end

    if (GetMobAction(elemental) ~= 0) then
        DespawnMob(elemental);
    end

end;