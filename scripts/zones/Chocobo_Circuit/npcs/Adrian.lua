-----------------------------------
-- Area: Chocobo_Circuit
--  NPC: Adrian
-- Standard Info NPC
-----------------------------------
package.loaded["scripts/zones/Chocobo_Circuit/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Chocobo_Circuit/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:startEvent(1);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;