-----------------------------------
-- Area: Xarcabard
--  NPC: qm1 (???)
-- Involved in Quests: The Three Magi
-- !pos -331 -29 -49 112
-----------------------------------
package.loaded["scripts/zones/Xarcabard/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/quests");
require("scripts/zones/Xarcabard/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)

    if (player:getQuestStatus(WINDURST,THE_THREE_MAGI) == QUEST_ACCEPTED and player:hasItem(1104) == false) then
        if (trade:hasItemQty(613,1) and trade:getItemCount() == 1) then -- Trade Faded Crystal
            player:tradeComplete();
            SpawnMob(17236201):updateClaim(player);
            npc:setStatus(STATUS_DISAPPEAR);
        end
    end
end;

function onTrigger(player,npc)
    player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;