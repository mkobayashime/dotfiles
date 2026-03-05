local recipes = vim.g["sandwich#default_recipes"]

table.insert(recipes, { buns = { "（", "）" } })
table.insert(recipes, { buns = { "【", "】" } })
table.insert(recipes, { buns = { "「", "」" } })
table.insert(recipes, { buns = { "『", "』" } })

vim.g["sandwich#recipes"] = recipes
