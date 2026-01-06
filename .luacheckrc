-- Luacheck configuration
std = "lua51+luajit"
globals = {
  "vim",  -- Neovim global
}
ignore = {
  "212",  -- Unused argument (common in Lua callbacks)
  "213",  -- Unused loop variable
}
max_line_length = 120
