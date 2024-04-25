void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false; // Flag to track if we created a new player instance

    if (!player) {
        player = new Player(nullptr);
        playerCreated = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Clean up allocated memory
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerCreated) {
            delete player; // Clean up allocated memory if a new player instance was created
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    } else {
        delete item; // Clean up item if player is online (assuming item ownership transfers to player)
    }

    if (playerCreated) {
        delete player; // Clean up allocated memory if a new player instance was created
    }
}
