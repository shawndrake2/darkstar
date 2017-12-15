-----------------------------------
-- Area: Temple of Uggalepih
--  NM:  Beryl-footed Molberry
-----------------------------------

function onMobSpawn(mob)
end;

function onMobDeath(mob, player, isKiller)
    SetServerVariable("[POP]Beryl-footed_Molberry",os.time() + 900); -- 15min

    local kills = player:getVar("EVERYONES_GRUDGE_KILLS");

    if (kills < 480) then
        player:setVar("EVERYONES_GRUDGE_KILLS",kills + 1);
    end
end;