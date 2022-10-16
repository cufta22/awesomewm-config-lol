local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local color = require('theme.colors')
local utils = require('ui.bar.utils')

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local launcher = awful.widget.launcher(
    {
        image = beautiful.lol_full_icon,
        menu = RC.mainmenu
    }
)

local play_button = wibox.container.margin(
    wibox.container {
        wibox.widget {
            utils.spacer,
            launcher,
            wibox.widget{
                font   = RC.vars.font.."10",
                markup = '    PLAY        ',
                align  = 'center',
                valign = 'center',
                widget = wibox.widget.textbox
            },

            layout = wibox.layout.align.horizontal
        },

        bg = color["xgreycl"],
        fg = color["xblue1"],
        widget = wibox.container.background,

        shape = gears.shape.transform(gears.shape.rectangular_tag) : rotate(math.pi) : translate(-98, -28),
        shape_clip = false,
        shape_border_width = 2,
        shape_border_color = color["xblue4"]

    },
0,
0,
5,
5
)

return play_button