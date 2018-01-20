-----------------------------------------
-- ID: 27556
-- Item: echad ring
-- Experience point bonus
-----------------------------------------
-- Bonus: +300% (original: 150%)
-- Duration: 24 hours (original: 720 min)
-- Max bonus: 3000000 exp (original: 30000 exp)
-----------------------------------------
require("scripts/globals/status");
-----------------------------------------

function onItemCheck(target)
    local result = 0;
    if (target:hasStatusEffect(EFFECT_DEDICATION) == true) then
        result = 56;
    end
    return result;
end;

function onItemUse(target)
   target:addStatusEffect(EFFECT_DEDICATION,300,0,86400,0,3000000);
end;
