-- I found this top section from the OTLand Forum
local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local unwanted_tilestates = { TILESTATE_PROTECTIONZONE, TILESTATE_HOUSE, TILESTATE_FLOORCHANGE, TILESTATE_TELEPORT, TILESTATE_BLOCKSOLID, TILESTATE_BLOCKPATH }

function onCastSpell(creature, variant)
    local target = creature:getTarget()
    local toPosition = false
    if target then
        toPosition = target:getPosition()
        toPosition:getNextPosition(target:getDirection(), 1)
    else
        toPosition = creature:getPosition()
        toPosition:getNextPosition(creature:getDirection(), 7)
    end

    local tile = toPosition and Tile(toPosition)
    if not tile then
        return false
    end

    for _, tilestate in pairs(unwanted_tilestates) do
        if tile:hasFlag(tilestate) then
            creature:sendCancelMessage("You cannot dash here.")
            return false
        end
    end

    -- Teleport the character
    creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    creature:teleportTo(toPosition)
    toPosition:sendMagicEffect(CONST_ME_TELEPORT)

    -- I added this section to try and make the effect of there being 5 duplicates trailing behind the original as it moved. Unfortunately, I couldn't get the about Dash portion to work correctly, it only appeared to teleport the charact when they were facing up and there were no duplicates.
    local currentPos = creature:getPosition()
    for i = 1, 5 do
        local clone = creature:clone()
        local newPos = Position(currentPos.x, currentPos.y, currentPos.z)
        newPos:getNextPosition(creature:getDirection(), i * 2) -- Adjust the distance between duplicates as needed
        clone:teleportTo(newPos)
        clone:setOutfit(creature:getOutfit())
        clone:getPosition():sendMagicEffect(CONST_ME_POFF) -- Adjust magic effect if needed
        -- Adjust transparency or color of the clone here
        clone:addHealth(-(i * 100)) -- Adjust health if needed
    end

    return combat:execute(creature, variant)
end
