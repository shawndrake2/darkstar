-----------------------------------
-- Area: South Gustaberg
--  NPC: qm1 (???)
-- Involved in Quest: The Cold Light of Day
-- !pos  744 0 -671 107
-----------------------------------
package.loaded["scripts/zones/South_Gustaberg/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/South_Gustaberg/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
      count = trade:getItemCount();
      gil = trade:getGil();

      if ((trade:hasItemQty(4514,1) or trade:hasItemQty(5793,1)) and count == 1 and gil == 0) then
        if (GetMobAction(17215494) == 0) then
            SpawnMob(17215494);
            player:tradeComplete();
        else
            player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
        end
    end
end;

function onTrigger(player,npc)
    player:messageSpecial(MONSTER_TRACKS);
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;
