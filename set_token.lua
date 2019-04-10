local request_method = ngx.var.request_method

if "GET" == request_method then
    ngx.exit(405)
    return
end

if "POST" == request_method then
    ngx.req.read_body()
    args = ngx.req.get_post_args()
end

if err == "truncated" then
    -- one can choose to ignore or reject the current request here
end

if not args then
    ngx.say("failed to get post args: ", err)
    return
end

token = args["token"]
val = args["val"]
expire = args["expire"]

if (nil == token) or (nil == val) then
    ngx.exit(412)  -- 缺少参数
    return
end

-- 设置缓存
local cache = import "cache"

cache.setCache(token, val, expire)
ngx.say(expire)

-- cache.setToken()