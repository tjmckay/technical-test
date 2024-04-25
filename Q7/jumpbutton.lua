-- I again found a template for this program on the OTLand Forum
function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:registerEvent("Jump_Window")
  
    local title = "Jump!"
    local message = "Click the button to jump to a new location!"
  
    local window = ModalWindow(1000, title, message)

    -- Adding the "Jump!" button
    local jumpButton = window:addButton(102, "Jump!")
  
    window:setDefaultEnterButton(102)
  
    -- Define a function to handle the scrolling action
    local function scrollAction()
        -- Get the current position of the button
        local currentX, currentY = jumpButton:getPosition()
        
        -- Calculate new position
        local newX = currentX - 10 -- Adjust the scrolling speed as needed
        local newY = math.random(10, 300) -- Random height
        
        -- Check if button reaches the left edge
        if newX < 10 then
            newX = 500 -- Reset to the right edge
        end
        
        -- Move the button to the new position
        jumpButton:move(newX, newY)
    end

    -- Register a timer to handle scrolling
    addEvent(scrollAction, 100) -- Adjust the scrolling speed as needed
  
    window:sendToPlayer(player)
    return true
end
