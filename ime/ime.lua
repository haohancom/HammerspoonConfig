local function Chinese()
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.Shuangpin")
end

local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- app to expected ime config
local app2Ime = {
    {'/Applications/iTerm.app', 'English'},
    {'/Applications/Google Chrome.app', 'English'},
    {'/System/Library/CoreServices/Finder.app', 'English'},
    {'/Applications/WeChat.app', 'Chinese'},
    {'/Applications/System Preferences.app', 'English'},
    {'/Applications/Preview.app', 'English'},
    {'/Applications/wechatwebdevtools.app', 'English'},
    {'/Applications/Intellij IDEA.app', 'English'},
}

function updateFocusAppInputMethod()
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            if expectedIme == 'English' then
                English()
            else
                Chinese()
            end
            break
        end
    end
end

-- for trouble shooting
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
    hs.alert.show("App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID())
end)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
