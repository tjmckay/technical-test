--I found this program on the OTLand Forum as well
function onUse(player, modalWindowId, buttonId, choiceId)  
    player:unregisterEvent("Jump_Window")
    local jumpButton
  
    if modalWindowId == 1000 then
        if buttonId == 100 then
            player:addItem(jumpButton, 1)
        end
    end
end