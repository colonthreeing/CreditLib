-- this file handles the custom UI for blind credits

-- could not for the life of me
-- figure out how to do this better
-- :P
CreditLib.blind_credits = {
    -- names indicate how many available strings
    one = {
        {
            string="One"
        },
    },
    two = {
        {
            string="One"
        },
        {
            string="Two"
        }
    },
    three = {
        {
            string="One"
        },
        {
            string="Two"
        },
        {
            string="Three"
        }
    },
    four = {
        {
            string="One"
        },
        {
            string="Two"
        },
        {
            string="Three"
        },
        {
            string="Four"
        }
    }
}

local create_UIBox_HUD_blind_ref = create_UIBox_HUD_blind
---@diagnostic disable-next-line: lowercase-global
function create_UIBox_HUD_blind()
    print("[CL] Creating custom HUD blind")
    local scale = 0.9
    local root = create_UIBox_HUD_blind_ref()

    table.insert(
        root.nodes,
        {
            n = G.UIT.R,
            config = {align = "cm", minh = 0.5, r = 0.1, colour = G.C.DYN_UI.DARK},
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText(
                            {
                                string = {{ref_table = CreditLib.blind_credits.one[1], ref_value = "string"}}
                                ,--{ref_table = CreditLib.blind_credits, ref_value = "msg"},
                                colours = {G.C.UI.TEXT_LIGHT},
                                shadow = true,
                                rotate = true,
                                silent = true,
                                float = true,
                                scale = 0.4 * scale,
                                y_offset = -4,
                                id = "HUD_blind_credits_text"
                            }
                        ),
                        id = "HUD_blind_credits_one",
                    }
                }
            },
        }
    )

    return root
end

-- TESTING ONLY
if _RELEASE_MODE == false then
    for blindi=1, 100 do
        SMODS.Blind {
            key = "hook_" .. blindi,
            dollars = 5,
            mult = 2,
            pos = { x = 0, y = 7 },
            boss = { min = 1 },
            boss_colour = HEX("a84024"),
            credits = {
                idea = { "Julie" },
                art = { "Julie" },
                code = { "Julie" }
            }
        }
    end
end

SMODS.current_mod.calculate = function(self, context)
    if context.setting_blind then
        local blind = G.GAME.blind.config.blind

        CreditLib.blind_credits.one = {
            {
                string = "This is a crafting table"
            }
        }

        -- G.HUD_blind:get_UIE_by_ID("HUD_blind_credits_one").states.visible = false
        -- G.E_MANAGER.add_event(
        --     Event {
        --         func = function()
        --             return true
        --         end
        --     }
        -- )
    end
end
