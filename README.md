# CreditLib

Balatro API library for easy implementation of a Credits badge in your balatro mods.

Requires SMODS.

To use it, simply add something like this to your SMODS definitions:

```lua
SMODS.Joker { -- or any other SMODS type that supports badges

	--[[
		Your joker code here
	]]

	credits = {
		art = "John Balatro",            -- A string alone works
		code = { "Author1", "Author2" }, -- or a table of names (will be automatically concatenated as 'Code: Author1, Author2')
		idea = "LocalThunk"              -- you can also leave out fields if you wish
	}
}
```

This is based on the work in the Balatro Multiplayer mod, which is in itself based on Cryptid. If either party wants me to remove the code from here then I will, and will try to remake it myself.

[Here is the source code that I modified from the Multiplayer repository](https://github.com/Balatro-Multiplayer/BalatroMultiplayer/blob/c3b0baf6c8a1a896cddb1aeccbd3b668dcc0fe8e/misc/utils.lua#L255)