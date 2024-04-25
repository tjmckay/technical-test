-- Release storage when player logs out
local function releaseStorage(player)
    -- Assuming setStorageValue returns true if successful
    if player:setStorageValue(1000, -1) then
        print("Storage released for player: " .. player:getName())
    else
        print("Failed to release storage for player: " .. player:getName())
    end
end

-- Event handler for player logout
function onLogout(player)
    -- Check if player has the specific storage value set to 1
    if player:getStorageValue(1000) == 1 then
        -- Schedule releaseStorage function to be executed after 1000 milliseconds (1 second)
        addEvent(releaseStorage, 1000, player)
    end
    -- Always return true to allow the player to log out
    return true
end
