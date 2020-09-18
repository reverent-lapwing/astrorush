-------------------------------------------------------------------
--See https://love2d.org/wiki/KeyConstant for reference
--lmb - left mouse button
--rmb - right mouse button
-------------------------------------------------------------------
--Abbreviations:
--en_t - top thruster
--en_b - bottom thruster
--en_tl - top-left thruster
--en_tr - top-right thruster
--en_bl - bottom-left thruster
--en_br - bottom-right thruster
--shld - toggle shields
--sens - toggle sensors
-------------------------------------------------------------------
keyBind.en_t = "w",
keyBind.en_b = "s",
keyBind.en_tl = "q",
keyBind.en_tr = "e",
keyBind.en_bl = "a",
keyBind.en_br = "d",

keyBind.shld = "rmb",
keyBind.sens = "tab",

keyBind.pause = "p",

keyBind.self_dest = "f9"
-------------------------------------------------------------------
--SCREEN RESOLUTION

screenWidth = 800
screenHeight = 600

fullscreen = false
-------------------------------------------------------------------
--If true then creates hi-score file in userfolder
---for Windows XP: C:\Documents and Settings\user\Application Data\LOVE\ or %appdata%\LOVE\
---for Windows Vista and 7: C:\Users\user\AppData\Roaming\LOVE or %appdata%\LOVE\
---for Linux: $XDG_DATA_HOME/love/ or ~/.local/share/love/
---for Mac: /Users/user/Library/Application Support/LOVE/

writefile = false
-------------------------------------------------------------------