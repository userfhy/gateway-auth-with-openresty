
```nginx
# nginx.conf
http {
    lua_shared_dict token_cache 10m;

    lua_package_path '/home/developer/lua/?.lua;;';
    lua_code_cache on;
    lua_socket_log_errors off;

    init_by_lua_block {
        _G.import = function(module)
           return require(ngx.var.PROJECT .. '.' .. module)
        end
    }

}
```

```nginx
# tianji-gateway-auth.conf
server {
    listen       80;
    server_name  localhost;

    charset utf-8;
    # access_log  /var/log/nginx/host.access.log  main;

    # 加入权限验证
    set $PROJECT tianji-gateway-auth;
    set $BASE_DIR  /home/developer/lua/$PROJECT;

    # access_by_lua_file $BASE_DIR/auth.lua;

    # 用于设置 token
    location = /set_token {
        content_by_lua_file $BASE_DIR/set_token.lua;
    }
    # 权限 END

}
```