return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup{
                options = {
                    position = "bottom",
                    },
            }
        end
        -- bufferline.nvim: 一个美观的缓冲区/标签行插件
        -- 它在编辑器顶部显示打开的缓冲区（类似于标签），提供更好的缓冲区管理
        -- 可以方便地在不同文件间切换，并提供自定义外观的选项
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        config = function()
            require("ibl").setup()
        end
        -- indent-blankline.nvim: 添加缩进参考线
        -- 在代码中显示垂直线来表示缩进级别，使代码结构更清晰
        -- 特别适用于Python等依赖缩进的语言，但对所有代码都有帮助
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = true,
        -- gitsigns.nvim: Git 集成插件
        -- 在代码旁边显示 git 状态（添加、修改、删除等）
        -- 提供内联 blame 信息，以及在 Neovim 中进行 git 操作的命令
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
        -- alpha-nvim: 启动屏幕插件
        -- 自定义 Neovim 的启动界面，可以显示最近打开的文件、书签等
        -- 这里使用了默认的 dashboard 主题配置
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
           require('illuminate').configure()
        end
        -- vim-illuminate: 自动高亮光标下的单词
        -- 当光标停在一个单词上时，会自动高亮文件中所有相同的单词
        -- 有助于快速识别变量、函数名等在文件中的其他出现位置
    },
}
