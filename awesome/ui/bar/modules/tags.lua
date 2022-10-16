local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local color = require('theme.colors')

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Function to update the tags
local update_tags = function(self, c3)
	local tagicon = self:get_children_by_id('icon_role')[1]

	if #c3:clients() > 0 and c3.selected then
        tagicon.image = beautiful.tag_selected_clients
    elseif c3.selected then
        tagicon.image = beautiful.tag_selected
    elseif #c3:clients() > 0 then
        tagicon.image = beautiful.tag_normal_clients
    else
        tagicon.image = beautiful.tag_normal
	end
end

local get_taglist = function(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = 0,
            layout = wibox.layout.fixed.horizontal,
        },
        style = {
            shape = gears.shape.circle,
        },
        buttons = gears.table.join(
            awful.button({}, 1, function (t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function (t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function (t) awful.tag.viewnext(t.screen) end)
        ),
        widget_template = {
            {
                id = 'icon_role',
                image = beautiful.tag_selected,
                -- valign = 'center',
                -- halign = 'center',
                forced_height = 40,
                forced_width = 40,
                widget = wibox.widget.imagebox,
            },
            -- id = 'background_role',
            widget = wibox.container.background,
            shape = gears.shape.circle,

            create_callback = function(self, c3, index, objects) update_tags(self, c3) end,

            update_callback = function(self, c3, index, objects) update_tags(self, c3) end
        }
    }
end

return get_taglist
