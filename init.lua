-- This uses a trick: you can first define the recipes using all of the base
-- colors, and then some recipes using more specific colors for a few non-base
-- colors available. When crafting, the last recipes will be checked first.

local dyes = {
	{"white",      "White",      "basecolor_white"},
	{"grey",       "Grey",       "basecolor_grey"},
	{"black",      "Black",      "basecolor_black"},
	{"red",        "Red",        "basecolor_red"},
	{"yellow",     "Yellow",     "basecolor_yellow"},
	{"green",      "Green",      "basecolor_green"},
	{"cyan",       "Cyan",       "basecolor_cyan"},
	{"blue",       "Blue",       "basecolor_blue"},
	{"magenta",    "Magenta",    "basecolor_magenta"},
	{"orange",     "Orange",     "excolor_orange"},
	{"violet",     "Violet",     "excolor_violet"},
	{"brown",      "Brown",      "unicolor_dark_orange"},
	{"pink",       "Pink",       "unicolor_light_red"},
	{"dark_grey",  "Dark Grey",  "unicolor_darkgrey"},
	{"dark_green", "Dark Green", "unicolor_dark_green"},
}

minetest.register_node("i3_color_demo:wool", {
	description = "Wool",
	tiles = {"wool_block.png"},
	paramtype2 = "color",
	palette = "wool_palette.png",
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 3,},
	sounds = default.node_sound_defaults(),
    preserve_metadata = function(pos, oldnode, oldmeta, drops)
        drops[1]:get_meta():set_string("description", dyes[oldnode.param2 + 1][2] .. " Wool")
    end,
})

for counter, dye in pairs(dyes) do
    local out_item = ItemStack(minetest.itemstring_with_palette("i3_color_demo:wool", counter - 1))
    out_item:get_meta():set_string("description", dyes[counter][2] .. " wool")
    minetest.register_craft({
        output = out_item:to_string(),
        type = "shapeless",
        recipe = {
            "i3_color_demo:wool",
            "dye:" .. dye[1]
        },
    })
end

-- modified https://gist.github.com/juhdanad/433a0aa7094ae0dceaf00924d6fd1e3b and
-- https://github.com/minetest/minetest/pull/5640#issuecomment-302868234
-- demo for https://github.com/minetest-mods/i3/issues/18

local out_item = ItemStack("default:dirt")
out_item:get_meta():set_string("description", " test description")
minetest.register_craft({
    output = out_item:to_string(),
    type = "shapeless",
    recipe = {
        "default:stone",
        "default:dirt"
    },
})