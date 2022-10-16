--[[
 _____ __ _ __ _____ _____ _____ _______ _____
|     |  | |  |  ___|  ___|     |       |  ___|
|  -  |  | |  |  ___|___  |  |  |  | |  |  ___|
|__|__|_______|_____|_____|_____|__|_|__|_____|
=============== @author cufta22 ===============
========= https://github.com/cufta22 ==========
--]]

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("config.variables")
modkey = RC.vars.modkey

-- Error handling
require("config.error-handling")

-- Themes
require("theme")

-- Custom Local Library: Config
local config = {
  layouts = require("config.layouts"),
  tags    = require("config.tags"),
  rules   = require("config.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local bindings = {
  globalbuttons = require("bindings.globalbuttons"),
  clientbuttons = require("bindings.clientbuttons"),
  globalkeys    = require("bindings.globalkeys"),
  bindtotags    = require("bindings.bindtotags"),
  clientkeys    = require("bindings.clientkeys"),
}

-- Menu
local menu = require("ui.menu")

-- Layouts
RC.layouts = config.layouts() -- Used in tags, and bar
awful.layout.layouts = RC.layouts

-- Tags
RC.tags = config.tags() -- Used in rules, tasklist, and globalkeys

-- Menu
-- Create a laucher widget and a main menu
RC.mainmenu = awful.menu({ items = menu() }) -- Used in globalkeys

-- Menubar configuration
menubar.utils.terminal = RC.vars.terminal

-- Mouse and Key bindings
RC.globalkeys = bindings.globalkeys()
RC.globalkeys = bindings.bindtotags(RC.globalkeys)

root.buttons(bindings.globalbuttons())
root.keys(RC.globalkeys)

-- Rules
awful.rules.rules = config.rules(
  bindings.clientkeys(),
  bindings.clientbuttons()
)

-- Statusbar: Wibar
require("ui.bar")

-- Signals
require("config.signals")

-- Autostart applications
require("config.autostart")