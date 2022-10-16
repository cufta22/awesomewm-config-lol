local awful     = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local color   = require("theme.colors")

local lain = require("lain")

local config_path = awful.util.getdir("config") .. "/theme/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Battery

-- fa.icon["battery_full"]
-- local icon_battery_dynamyc = fa.icon["loading"]

local icon_battery_dynamyc = wibox.widget{
    image  = config_path.."assets/bar/battery_3.png",
    forced_width = 20,
    forced_height = 20,
    valign = "center",
    align = "center",
    widget = wibox.widget.imagebox,
}

local widget_battery_perc = wibox.widget{
    markup = '',
    font   = RC.vars.font.."10",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
}

lain.widget.bat({
    timeout = 3, -- Refresh rate
    settings = function()
        local new_img, perc = "", tonumber(bat_now.perc) or 0
        local new_txt = "  " .. perc .. "%"

        if perc <= 30 then
            new_img = gears.color.recolor_image(config_path.."assets/bar/battery_1.png", color["xgrey1_5"])
        elseif perc <= 70 then
            new_img = gears.color.recolor_image(config_path.."assets/bar/battery_2.png", color["xblue4"])
        elseif perc <= 100 then
            new_img = gears.color.recolor_image(config_path.."assets/bar/battery_3.png", color["xblue3"])
        end

        if bat_now.ac_status == 1 then
            new_img = gears.color.recolor_image(config_path.."assets/bar/battery_plug.png", color["xgold4"])
            new_txt = "  ^" .. perc .. "%"
        end

        icon_battery_dynamyc:set_image(new_img)
        widget_battery_perc:set_markup(new_txt)

        if bat_now.ac_status == "N/A" and perc == 0 then
            icon_battery_dynamyc:set_image(gears.color.recolor_image(config_path.."assets/bar/battery_3.png", color["xblue3"]))
            widget_battery_perc:set_markup("  Loading")
        end
    end
})

return {
    ["icon"] = icon_battery_dynamyc,
    ["perc"] = widget_battery_perc
}