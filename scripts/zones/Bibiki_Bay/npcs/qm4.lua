-----------------------------------
-- Area: Bibiki Bay
--  NPC: ??? COP mission spawn Dalham
-- !pos
-----------------------------------
package.loaded["scripts/zones/Bibiki_Bay/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Bibiki_Bay/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    if (player:getCurrentMission(COP) == CALM_BEFORE_THE_STORM and GetMobAction(16793858) == 0 and player:getVar("COP_Dalham_KILL") == 0) then
      SpawnMob(16793858):updateClaim(player);
    elseif (player:getCurrentMission(COP) == CALM_BEFORE_THE_STORM and player:getVar("COP_Dalham_KILL") == 1) then
      player:startEvent(41);
    else
       player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
    end
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 41) then
      player:setVar("COP_Dalham_KILL",2);
    end
end;