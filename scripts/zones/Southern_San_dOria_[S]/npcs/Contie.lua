-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Contie
-- @zone 80
-- !pos 138 0 59
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria_[S]/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Southern_San_dOria_[S]/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:startEvent(612);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;