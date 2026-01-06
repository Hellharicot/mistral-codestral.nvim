-- Luacheck configuration
std = "lua51+luajit"
globals = {
  "vim",  -- Neovim global
}
ignore = {
  "211/_.*",  -- Unused variable starting with _ (intentionally unused)
  "212",  -- Unused argument (common in Lua callbacks)
  "213",  -- Unused loop variable
}
max_line_length = 120
