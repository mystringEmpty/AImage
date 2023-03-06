msg_reply.nai_draw = {
    keyword = {
        prefix = {".nai"}
    },
    limit = {
        grp_var = {
            nai_on = true,
            nai_ban = false,
        },
        user_var = {
            nai_ban = false,
        },
        cd = {
            user = { aimage = 30 },
        },
        today = {
            user = { aimage = 20 },
        },
        lock = "aimage"
    },
    echo = {
        lua = "nai.draw"
    }
}
msg_reply.nai_off = {
    keyword = {
        prefix = {".nai off"}
    },
    limit = {
        grp_id = { nor = {0} },
        grp_var = { nai_on = true }
    },
    echo = function()
        setGroupConf(msg.gid,"nai_on",false)
        return "{reply_nai_off}"
    end
}
msg_reply.nai_on = {
    keyword = {
        prefix = {".nai on"}
    },
    limit = {
        grp_id = { nor = {0} },
        grp_var = { nai_on = false }
    },
    echo = function()
        if getUserConf(msg.uid,"trust")>0 or msg.grpAuth>1 then
            setGroupConf(msg.gid,"nai_on",true)
            return "{reply_nai_on}"
        else
            return "{strPermissionDeniedErr}"
        end
    end
}
msg_reply.nai_ban = {
    keyword = {
        prefix = {".nai ban"}
    },
    limit = {
        user_var = { trust = { at_least = 4 }}
    },
    echo = function()
        local type,id = msg.suffix:match("^[%s]*([ug]?)[^%d]*(%d*)[%s]*$")
        if type=='g' then
            if #id==0 then return "{strGroupIDEmpty}" end
            msg.tgt_chat = getGroupConf(id,"name").."("..id..")"
            setGroupConf(id,"nai_ban",true)
        else
            if #id==0 then return "{strUIDEmpty}" end
            msg.tgt_chat = getUserConf(id,"name").."("..id..")"
            setUserConf(id,"nai_ban",true)
        end
        return "{reply_nai_ban}"
    end
}
msg_reply.nai_unban = {
    keyword = {
        prefix = {".nai unban"}
    },
    limit = {
        user_var = { trust = { at_least = 4 }}
    },
    echo = function()
        local type,id = msg.suffix:match("^[%s]*([ug]?)[^%d]*(%d*)[%s]*$")
        if type=='g' then
            if #id==0 then return "{strGroupIDEmpty}" end
            msg.tgt_chat = getGroupConf(id,"name").."("..id..")"
            setGroupConf(id,"nai_ban")
        else
            if #id==0 then return "{strUIDEmpty}" end
            msg.tgt_chat = getUserConf(id,"name").."("..id..")"
            setUserConf(id,"nai_ban")
        end
        return "{reply_nai_unban}"
    end
}