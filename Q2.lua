function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?;" --changed the SQL query to avoit SQL injection
    local resultId = db.storeQuery(selectGuildQuery, memberCount)  --removed the string.format

    -- Check if the query was successful
    if resultId == nil then
        print("Error executing query")
        return
    end

    -- Fetch all rows from the result
    local row = db.fetchRow(resultId)
    while row do
        local guildName = row.name
        print(guildName)
        row = db.fetchRow(resultId)
    end

    -- Free the result set
    db.freeResult(resultId)
end
