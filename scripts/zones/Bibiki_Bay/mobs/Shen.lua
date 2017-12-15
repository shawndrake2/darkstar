-----------------------------------
-- Area: Bibiki Bay
--  MOB: Shen
-----------------------------------

function onMobSpawn(mob)
end;

function onMobFight(mob,target)

    local Shen = mob:getID();

    if (mob:getBattleTime() % 45 == 0) then
        if (GetMobAction(Shen+1) == 0) then
            SpawnMob(Shen+1):updateEnmity(target);
        elseif (GetMobAction(Shen+2) == 0) then
            SpawnMob(Shen+2):updateEnmity(target);
        end
    end

end;

function onMobDeath(mob, player, isKiller)
end;

function onMonsterMagicPrepare(mob,target)
    -- casts Water IV, Waterga III, Flood, Drown
    local rnd = math.random();

    if (rnd < 0.5) then
        return 201; -- waterga 3
    elseif (rnd < 0.7) then
         return 172; -- water 4
    elseif (rnd < 0.9) then
        return 214; -- flood
    else
        return 240; -- drown
    end

end;
