-- This is based on the Balatro Multiplayer implementation
-- Which is itself based on Cryptid.
-- If either party wants me to remove the code,
-- I absolutely will, and will implement it myself.
-- https://github.com/Balatro-Multiplayer/BalatroMultiplayer/blob/c3b0baf6c8a1a896cddb1aeccbd3b668dcc0fe8e/misc/utils.lua#L255

local logger = { -- Placeholder logger, for when DebugPlus isn't available
    log = print,
    debug = print,
    info = print,
    warn = print,
    error = print
}

-- local dpAPIAvailable, dpAPI = pcall(require, "debugplus-api")
-- if dpAPIAvailable and dpAPI.isVersionCompatible(1) then
--     dpAPI.registerID("CreditLib")
--     logger = debugplus.logger
-- end

SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
}

CreditLib = {}

function CreditLib.get_mod_creds(obj)
    local strings = {}
    for _, v in ipairs({ "art", "idea", "code" }) do
        if obj.credits[v] then
            local authors = ""

            if type(obj.credits[v]) == "string" then
                authors = obj.credits[v]
            else
                authors = table.concat(obj.credits[v], ", ")
            end

            if authors ~= "" then
                strings[#strings + 1] = localize({ type = "variable", key = "a_" .. v, vars = { authors } })[1]
            end
        end
    end

    return strings
end

function CreditLib.strings_to_dyntext(strings)
    local ct = {}

    for i = 1, #strings do
        ct[i] = {
            string = strings[i],
        }
    end

    return ct
end

function CreditLib.ensure_credits_available(obj)
    if obj.credits then -- ensure all fields exist
        obj.credits.art = obj.credits.art or {}
        obj.credits.idea = obj.credits.idea or obj.credits.concept or {}
        obj.credits.code = obj.credits.code or {}
    else -- if it uses credit instead of credits (for 3xCredit compatibility)
        obj.credits = {}
        obj.credits.art = obj.credit.art or {}
        obj.credits.idea = obj.credit.idea or obj.credit.concept or {}
        obj.credits.code = obj.credit.code or {}
    end
end

function CreditLib.add_credit_to_card(ref_table, index, credits)
    ref_table[index].credit = credits
end


local create_mod_badges_ref = SMODS.create_mod_badges
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.create_mod_badges(obj, badges)
    create_mod_badges_ref(obj, badges)
    if obj and (obj.credits or obj.credit) then
        local bg_color = HEX("FF0000")
        local text_color = G.C.WHITE

        if obj.original_mod then
            local mod = SMODS.Mods[obj.original_mod.id]
            bg_color = mod.badge_colour
            text_color = mod.badge_text_colour
        end

        CreditLib.ensure_credits_available(obj)

        local function calc_scale_fac(text)
            local size = 0.9
            local font = G.LANG.font
            local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
            local calced_text_width = 0
            -- Math reproduced from DynaText:update_text
            for _, c in utf8.chars(text) do
                local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
                    + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
                calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
            end
            local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
            return scale_fac
        end

        if obj.credits.art or obj.credits.code or obj.credits.idea then
            local scale_fac = {}
            local min_scale_fac = 1
            local strings = CreditLib.get_mod_creds(obj)

            for i = 1, #strings do
                scale_fac[i] = calc_scale_fac(strings[i])
                min_scale_fac = math.min(min_scale_fac, scale_fac[i])
            end

            local ct = CreditLib.strings_to_dyntext(strings)

            local badge = {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            colour = bg_color,
                            r = 0.1,
                            minw = 2 / min_scale_fac,
                            minh = 0.36,
                            emboss = 0.05,
                            padding = 0.03 * 0.9,
                        },
                        nodes = {
                            { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                            {
                                n = G.UIT.O,
                                config = {
                                    object = DynaText({
                                        string = ct or "ERROR",
                                        colours = { text_color },
                                        silent = true,
                                        float = true,
                                        shadow = true,
                                        offset_y = -0.03,
                                        spacing = 1,
                                        scale = 0.33 * 0.9,
                                    }),
                                },
                            },
                            { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        },
                    },
                },
            }

            badges[#badges + 1] = badge
        end
    end
end

-- not finished
-- assert(SMODS.load_file("lib/ui/blind.lua"))()

return CreditLib
