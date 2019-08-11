-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Goblin Poacher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    dsp.regime.checkRegime(player, mob, 125, 2, dsp.regime.type.FIELDS)
end;
