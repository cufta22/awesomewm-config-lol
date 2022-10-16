
local wibox = require("wibox")
local lain = require("lain")
local gears = require("gears")
local xresources = require("beautiful.xresources")

local color = require("theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local H = {}

H.spacer = wibox.widget.textbox(" ")
H.spacerL = wibox.widget.textbox("   ")
H.spacerXL = wibox.widget.textbox("     ")

H.spacerline = wibox.widget.textbox(" | ")

-- Separators lain
local separators  = lain.util.separators
H.arrow_1 = function ( color ) return separators.arrow_right("alpha", color) end
H.arrow_2 = function ( color ) return separators.arrow_right(color, "alpha") end

H.widget_margin = function ( widget, margin_top, margin_bot )
    margin_top = margin_top or 8
    margin_bot = margin_bot or 8

    return wibox.container.margin(
      wibox.widget { widget, layout = wibox.layout.align.horizontal },
      0,
      0,
      margin_top,
      margin_bot
    )
  end

H.systray_wrap = function ( widget )
  --   return wibox.container.margin(
  --     wibox.container {
  --         wibox.widget {
  --             widget,
  --             layout = wibox.layout.align.horizontal
  --         },

  --         bg = color["xgreycl"],
  --         fg = color["xblue1"],
  --         widget = wibox.container.background,

  --         shape = gears.shape.rectangular_tag,
  --         shape_clip = false,
  --         shape_border_width = 2,
  --         shape_border_color = color["xblue4"]

  --     },
  --     0,
  --     0,
  --     0,
  --     0
  -- )
  return wibox.widget {
    {
      {
          widget,
          left   = 12,
          top    = 4,
          bottom = 4,
          right  =12,
          widget = wibox.container.margin,
      },
      bg            = color["xgreycl"],
      shape         = gears.shape.rounded_rect,
      shape_clip    = true,
      shape_border_width    = 2,
      shape_border_color    = color["xgold4"],
      widget        = wibox.container.background,
    },
    left   = 0,
    top    = 5,
    bottom = 5,
    right  = 0,
    widget = wibox.container.margin,
  }

  end

return H