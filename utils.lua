local _M = {
    _VERSION = "1.0.0",
    _AUTHOR = "fhy"
}

    function _M.is_include(value, tab)
        for k,v in ipairs(tab) do
            if v == value then
                return true
            end
        end
        return false
    end

    function _M.strSplit(delimeter, str)
        local find, sub, insert = string.find, string.sub, table.insert
        local res = {}
        local start, start_pos, end_pos = 1, 1, 1
        while true do
            start_pos, end_pos = find(str, delimeter, start, true)
            if not start_pos then
                break
            end
            insert(res, sub(str, start, start_pos - 1))
            start = end_pos + 1  
        end
        insert(res, sub(str,start))
        return res
    end

return _M