-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm10 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -139.895 -5.500 154.513 200
-----------------------------------
package.loaded["scripts/zones/Garlaige_Citadel/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/zones/Garlaige_Citadel/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    local hittingTheMarquisateHagainCS = player:getVar("hittingTheMarquisateHagainCS");

    if (hittingTheMarquisateHagainCS == 6) then
        player:messageSpecial(PRESENCE_FROM_CEILING);
        player:setVar("hittingTheMarquisateHagainCS",7);
    end

end;

function onEventUpdate(player,csid,option)
    -- printf("CSID2: %u",csid);
    -- printf("RESULT2: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;
