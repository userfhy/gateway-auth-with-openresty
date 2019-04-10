-- file myapp.lua: example "cache" module
local _M = {}

function _M.setCache(key, val, expire)
    if not expire then
        expire = 0
    end
    local cache_ngx = ngx.shared.token_cache
    local succ, err, forcible = cache_ngx:set(key, val, expire)
    return succ
end

function _M.getCache(key)
    local cache_ngx = ngx.shared.token_cache
    local value = cache_ngx:get(key)
    return value
end

return _M