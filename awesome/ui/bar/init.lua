local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local color = require("theme.colors")
local utils = require("ui.bar.utils")

local dpi = xresources.apply_dpi

local widgets = {
  wallpaper      = require("ui.wallpaper"),
  launcher       = require("ui.bar.modules.launcher"),
  get_taglist    = require("ui.bar.modules.tags"),
  get_tasklist   = require("ui.bar.modules.tasks"),
  get_layoutbox  = require("ui.bar.modules.layoutbox"),
  keyboard       = require("ui.bar.modules.keyboard"),
  clock          = require("ui.bar.modules.clock"),
  battery        = require("ui.bar.modules.battery"),
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Wibar

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create the wibox
  s.wibox = awful.wibar({
    position = "top",
    screen = s,
    -- width = s.geometry.width,
    height = dpi(40),
    -- opacity = 0.5
    bg = color["xgreyhx"].."F2"
  })

  -- Add widgets to the wibox
  s.wibox:setup {
    layout = wibox.layout.align.horizontal,

    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,

      utils.spacerXL,
      widgets.launcher,

      utils.spacerXL,

      widgets.get_taglist(s),
    },

    nil, -- Nothing in the middle

    -- {-- Middle widget
    --   widgets.get_tasklist(s),
    -- },

    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,

      utils.spacerXL,
      utils.widget_margin(widgets.battery.icon, 10, 0),
      utils.widget_margin(widgets.battery.perc, 0, 2),
      utils.spacerXL,

      utils.spacerL,
      utils.systray_wrap(wibox.widget.systray()),
      utils.spacerXL,

      utils.spacer,
      widgets.clock,
      utils.spacerXL,

      utils.widget_margin(widgets.get_layoutbox(s)),
      utils.spacerXL,
    },
  }
end)

