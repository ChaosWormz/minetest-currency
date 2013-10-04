print(" Currency mod loading... ")
dofile(minetest.get_modpath("currency").."/craftitems.lua")
print("[Currency] Craft_items Loaded!")
dofile(minetest.get_modpath("currency").."/shop.lua")
print("[Currency] Shop Loaded!")
dofile(minetest.get_modpath("currency").."/barter.lua")
print("[Currency]  Barter Loaded!")
dofile(minetest.get_modpath("currency").."/safe.lua")
print("[Currency] Safe Loaded!")
dofile(minetest.get_modpath("currency").."/crafting.lua")
print("[Currency] Crafting Loaded!")

players_income = {}

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime;
    if timer >= 720 then --720 for one day
        timer = 0
        for _,player in ipairs(minetest.get_connected_players()) do
                local name = player:get_player_name()
                if players_income[name] == nil then
                    players_income[name] = 0
                end
                players_income[name] = 1
                print("[Currency] basic income for "..name.."")
        end
    end
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
    if not digger then return end
    local name = digger:get_player_name()
    if players_income[name] == nil then
        players_income[name] = 0
    end
    if players_income[name] > 0 then
        count = players_income[name]
        local inv = digger:get_inventory()
        inv:add_item("main", {name="currency:minegeld_5", count=count})
        players_income[name] = 0
        print("Currency] added basic income for "..name.." to inventory")
    end
end)
