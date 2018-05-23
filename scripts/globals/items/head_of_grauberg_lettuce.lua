-----------------------------------------
-- ID: 5688
-- Item: Head of Grauberg Lettuce
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Agility 1
-- Vitality -3
-----------------------------------------
require("scripts/globals/status");
-----------------------------------------

function onItemCheck(target)
    local result = 0;
    if (target:hasStatusEffect(dsp.effect.FOOD) == true or target:hasStatusEffect(dsp.effect.FIELD_SUPPORT_FOOD) == true) then
        result = 246;
    end
    return result;
end;

function onItemUse(target)
    target:addStatusEffect(dsp.effect.FOOD,0,0,300,5688);
end;

function onEffectGain(target, effect)
    target:addMod(dsp.mod.AGI, 1);
    target:addMod(dsp.mod.VIT, -3);
end;

function onEffectLose(target, effect)
    target:delMod(dsp.mod.AGI, 1);
    target:delMod(dsp.mod.VIT, -3);
end;
