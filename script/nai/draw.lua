local hist = getSelfData("aimage/user_hist.json")
local tags = msg.suffix:match("^[%s]*(.-)[%s]*$")
if #tags==0 then
    if not hist[msg.fromUser] then
        return "{help:aimage}"
    else
        tags = hist[msg.fromUser]
    end
else
    hist[msg.fromUser] = tags
end
local api = "http://261090.proxy.nscc-gz.cn:8888/"
local prompt = "masterpiece, best quality, " .. tags
local frmdata = {
    prompt = prompt,
    width = 512,
    height = 768,
    cfg_scale = 12,
    n_iter = 1,
    steps = 28,
    seed = -1,
    batch_size = 1 ,
    sampler_index = "Euler a" ,
    negative_prompt = "nsfw, lowres, text, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, blurry, sex, missing arms,lowleg, missing legs, extra arms, extra legs"
}
if tags:find("full[%s_]*body") then
    frmdata.height = 1024
end
local json = require("json")
msg:echo("{reply_nai_waiting}")
local status, rcv_data = http.post(api, json.encode(frmdata))
if status then
    return "[CQ:image,url=" .. rcv_data .. "]\n原图链接:"..rcv_data
end
log(rcv_data)
return "访问网络失败!"..msg:format(rcv_data)