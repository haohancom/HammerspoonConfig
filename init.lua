print('==================================================')
require "headphone.headphone"
require "reload.reload"
require "ime.ime"


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
    --hs.messages.iMessage("+8613275633310", "test")
    --method = hs.keycodes.currentSourceID()
    --location = hs.location:currentRegion()
    --hs.notify.new({title="Hammerspoon", informativeText=location}):send()
    hs.http.post("https://api.day.app/bn43Uypce3mj7ywaZMThR4/b%20a/c?icon=https://cdn-icons-png.flaticon.com/512/295/295680.png&group=test",nil, {["Content-Type"] = "text/plain"})
end)
