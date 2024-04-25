local combat = Combat()                                     --Set up the initial combat conditions, taken from the eternal_winter.lua spell
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

-- Alternate combat areas for multiple regions
local alternateArea = true
local area1 = createCombatArea(AREA_CIRCLE4X4) -- custom made region in the spells.lua file to have the ice tornados show up in the correct spot
local area2 = createCombatArea(AREA_CROSS4X4)  -- another custom made region in the spells.lua file to have the ice tornados show up in the correct spot

function toggleCombatArea() --added this section to make the tornados switch between the two combat areas
    if alternateArea then
        combat:setArea(area1)
    else
        combat:setArea(area2)
    end
    alternateArea = not alternateArea
end

function onGetFormulaValues(player, level, magicLevel) -- taken from the eternal
    local min = (level / 5) + (magicLevel * 5.5) + 25
    local max = (level / 5) + (magicLevel * 11) + 50
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
    local durationInSeconds = 10 -- to make the spell last longer like in the video
    creature:addCondition(CONDITION_INFIGHT, durationInSeconds * 1000)
    toggleCombatArea() -- Start with the initial area
    local executeResult = combat:execute(creature, variant)
    addEvent(toggleCombatArea, durationInSeconds * 1000) -- Schedule area toggle after duration
    return executeResult
end
