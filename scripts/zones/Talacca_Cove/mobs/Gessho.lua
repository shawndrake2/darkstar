-----------------------------------
-- Area: Talacca Cove
-- MOB: Gessho
-----------------------------------
package.loaded["scripts/zones/Talacca_Cove/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/status");
require("scripts/zones/Talacca_Cove/TextIDs");
-----------------------------------

function onMobInitialize(mob)
end;

function onMobEngaged(mob,target)
end;

function onMobFight(mob,target)
    if(mob:getID() == 17010725) then
        local chance = math.random(1,100);

        if (chance == 50) then
            local clones = math.random(1,6);
            for i=1,clones,1 do SpawnMob(mob:getID()+i) end
        end

        if (mob:getHPP() <= 15) then
            mob:getBattlefield():win();
        end
    else
        local count = mob:getLocalVar("DespawnCount");
        mob:setLocalVar("DespawnCount", count+1);

        if (count == 100) then
            DespawnMob(mob:getID());
        end
    end
end;

function onSpellPrecast(mob, spell)
end;

function onMonsterMagicPrepare(mob, target)
end;

function onMobDespawn(mob, player, isKiller)
end;

function onMobDeath(mob, player, isKiller)
end;
