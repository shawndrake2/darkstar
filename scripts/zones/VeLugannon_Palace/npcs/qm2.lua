-----------------------------------
-- Area: VeLugannon Palace
--  NPC: qm2 (???)
-- Notes: Used to spawn Brigandish Blade
-- !pos 0.1 0.1 -286 177
-----------------------------------
package.loaded["scripts/zones/VeLugannon_Palace/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/VeLugannon_Palace/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)

    if (GetMobAction(17502568) == 0 and trade:hasItemQty(16575,1) and trade:getItemCount() == 1) then -- Trade Curtana
        player:tradeComplete();
        SpawnMob(17502568):updateClaim(player);
        npc:setStatus(STATUS_DISAPPEAR);
    end
end;

function onTrigger(player,npc)
    player:startEvent(2);
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;