require("tokyonight").setup {
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",
        floats = "dark",
    },
    lualine_bold = true,
}
-- default colorscheme
vim.cmd [[colorscheme tokyonight-moon]]
