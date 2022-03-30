
-- SONY WH-1000XM3
local bleDeviceID = 'cc-98-8b-a7-9e-2f'


function bluetoothSwitch(state)
  -- state: 0(off), 1(on)
  cmd = "/usr/local/bin/blueutil --power "..(state)
  hs.notify.new({title="Hammerspoon", informativeText=cmd}):send()
  --print(cmd)
  result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

function disconnectBluetooth()
  cmd = "/usr/local/bin/blueutil --unpair "..(bleDeviceID)
  hs.notify.new({title="Hammerspoon", informativeText=cmd}):send()
  result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

function connectBluetooth()
  cmd = "/usr/local/bin/blueutil --pair "..(bleDeviceID)
  hs.notify.new({title="Hammerspoon", informativeText=cmd}):send()
  result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

function caffeinateCallback(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidSleep) then
        hs.notify.new({title="Hammerspoon", informativeText="screensDidSleep"}):send()
    elseif (eventType == hs.caffeinate.watcher.screensDidWake) then
        hs.notify.new({title="Hammerspoon", informativeText="screensDidWake"}):send()
    elseif (eventType == hs.caffeinate.watcher.screensDidLock) then
        hs.notify.new({title="Hammerspoon", informativeText="screensDidLock"}):send()
      disconnectBluetooth()
    --elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
        --hs.notify.new({title="Hammerspoon", informativeText="screensDidUnlock"}):send()
      --connectBluetooth()
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()
