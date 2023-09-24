vim.g.sandwich_no_default_key_mappings = 1

local recipes = vim.g["sandwich#default_recipes"]

table.insert(recipes, { buns = { "（", "）" } })
table.insert(recipes, { buns = { "【", "】" } })
table.insert(recipes, { buns = { "「", "」" } })
table.insert(recipes, { buns = { "『", "』" } })

vim.g["sandwich#recipes"] = recipes
