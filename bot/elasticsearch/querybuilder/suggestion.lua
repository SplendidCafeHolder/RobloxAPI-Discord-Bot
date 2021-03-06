local suggestion = {}
suggestion.__index = suggestion

function suggestion:Add(obj)
    self.unserialized[#self.unserialized + 1] = obj
end

function suggestion:Serialize()
    local serializedQuery = {}
    for _,unserialized in pairs(self.unserialized) do
        local index, serializedObj = unserialized:Serialize()
        serializedQuery[index] = serializedObj
    end
    serializedQuery.text = self.text
    return self.indexName, serializedQuery
end

function suggestion:new(indexName)
    local suggestionObj = {
        text = nil,
        indexName = indexName,
        unserialized = {}
    }
    setmetatable(suggestionObj, suggestion)
    return suggestionObj
end

return suggestion