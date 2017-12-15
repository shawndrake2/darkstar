-----------------------------------
-- Area: Sacrificial Chamber
--  MOB: Sable-tongued_Gonberry
-- BCNM: Jungle Boogymen
-----------------------------------

function onMobSpawn(mob)
end;

function onMobEngaged(mob,target)
end;

function onMobDeath(mob, player, isKiller)

    local kills = player:getVar("EVERYONES_GRUDGE_KILLS");

    if (kills < 480) then
        player:setVar("EVERYONES_GRUDGE_KILLS",kills + 1);
    end

end;