-- Removes a member from a player's party by name
function removeMemberFromParty(playerId, memberName) --changed function name to make it more clear
    local player = Player(playerId)
    local party = player:getParty()
    
    local members = party:getMembers()
    for _, member in ipairs(members) do --used ipairs to keep member order
        if member:getName() == memberName then
            party:removeMember(member)
            return true  -- Exiting function after removal
        end
    end
    
    return false  -- Member not found
end
