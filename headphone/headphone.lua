function bluetoothSwitch(state)
  -- state: 0(off), 1(on)
  cmd = "/usr/local/bin/blueutil --power "..(state)
  result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

-- SONY WH-1000XM3
local sonyHeadphoneID = 'cc-98-8b-a7-9e-2f'

function caffeinateCallback(eventType)
    if (eventType == hs.caffeinate.watcher.systemWillSleep) then
        bluetoothSwitch(0)
        hs.messages.iMessage("+8613275633310", "bluetooth closed")
        hs.http.post("https://api.day.app/bn43Uypce3mj7ywaZMThR4/Bluetooth%20Management/Bluetooth%20is%20disabled?icon=https://cdn-icons-png.flaticon.com/512/295/295680.png&group=Bluetooth",nil, {["Content-Type"] = "text/plain"})
    elseif (eventType == hs.caffeinate.watcher.systemDidWake) then
        bluetoothSwitch(1)
        hs.messages.iMessage("+8613275633310", "bluetooth opened")
        hs.http.post("https://api.day.app/bn43Uypce3mj7ywaZMThR4/Bluetooth%20Management/Bluetooth%20is%20enabled?icon=https://cdn-icons-png.flaticon.com/512/295/295680.png&group=Bluetooth",nil, {["Content-Type"] = "text/plain"})
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()

