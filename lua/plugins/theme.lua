return {
    {
        "folke/tokyonight.nvim", -- Tokyo Night 主题插件，提供一种优美的 Neovim 主题
        dependencies = {
            "nvim-lualine/lualine.nvim", -- Lualine 状态栏插件，用于美化和增强 Neovim 的状态栏
            "nvim-tree/nvim-web-devicons", -- nvim-web-devicons 插件，为 Neovim 提供文件图标支持
            "utilyre/barbecue.nvim", -- Barbecue 状态栏插件，用于显示文件路径和上下文信息
            "SmiteshP/nvim-navic", -- Navic 插件，为 Neovim 提供导航栏支持
        },
        config = function()
            vim.cmd[[colorscheme tokyonight-storm]] -- 设置 Neovim 使用 Tokyo Night 主题的 storm 变体
            require('lualine').setup({
                options = {
                    theme = 'tokyonight' -- 将 Lualine 的主题设置为 Tokyo Night
                },
            })
            require('barbecue').setup {
                theme = 'tokyonight', -- 将 Barbecue 的主题设置为 Tokyo Night
            }
        end
    },
}
