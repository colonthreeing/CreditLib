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

This mod also provides the 3xCredits mod's api, so it can be installed in its place.

As such, you can also define credits with the `credit` field, or use `concept` instead of `idea`, and it will function identically. A table of values is also still supported for 3xCredits mode, and you can mix and match `idea` and `concept` in either mode.

So, the earlier example could look more like this:

```lua
SMODS.Joker {
	credit = { -- credit instead of credits
		art = "John Balatro",           -- same
		code = { "Author1", "Author2" } -- dictionary allowed
		concept = "LocalThunk"          -- rather than "idea"
	}
}
```

This is based on the work in the Balatro Multiplayer mod, which is in itself based on Cryptid. If either party wants me to remove the code from here then I will, and will try to remake it myself.

[Here is the source code that I modified from the Multiplayer repository](https://github.com/Balatro-Multiplayer/BalatroMultiplayer/blob/c3b0baf6c8a1a896cddb1aeccbd3b668dcc0fe8e/misc/utils.lua#L255)