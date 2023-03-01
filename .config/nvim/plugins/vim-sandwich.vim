let g:sandwich_no_default_key_mappings = 1

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [{ 'buns': ['（', '）'] }]
let g:sandwich#recipes += [{ 'buns': ['【', '】'] }]
let g:sandwich#recipes += [{ 'buns': ['「', '」'] }]
let g:sandwich#recipes += [{ 'buns': ['『', '』'] }]
