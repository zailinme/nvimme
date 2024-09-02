return {
    {
        -- accelerated-jk: 加速 j 和 k 的移动速度
        "rhysd/accelerated-jk",
        keys = {
            { "j", "<Plug>(accelerated_jk_gj)" }, -- 加速向下移动
            { "k", "<Plug>(accelerated_jk_gk)" }, -- 加速向上移动
        },
    },
    {
        -- persistence.nvim: 自动保存和恢复会话
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        keys = {
            { "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]] },        -- 加载上次会话
            { "<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]] }, -- 加载最后一次会话
            { "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]] },        -- 停止自动保存当前会话
        },
        config = true, -- 使用默认配置
    },
    {
        -- nvim-autopairs: 自动补全括号
        "windwp/nvim-autopairs",
        event = "VeryLazy", -- 延迟加载
        opts = {
            enable_check_bracket_line = false, -- 禁用括号行检查
        },
    },
    {
        -- nvim-lastplace: 记住上次编辑位置
        "ethanholz/nvim-lastplace",
        config = true, -- 使用默认配置
    },
    {
        -- flash.nvim: 快速跳转插件
        "folke/flash.nvim",
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash", -- 普通跳转
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter", -- 使用 Treesitter 跳转
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash", -- 远程跳转
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search", -- Treesitter 搜索跳转
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search", -- 切换 Flash 搜索
            },
        },
        config = true -- 使用默认配置
    },
    {
        -- spelunker.vim: 高级拼写检查
        "kamykn/spelunker.vim",
        event = "VeryLazy", -- 延迟加载
        config = function()
            vim.g.spelunker_check_type = 2 -- 设置检查类型
        end
    },
    {
        -- neo-tree.nvim: 文件树插件
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- 推荐使用的图标插件
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Open the neo-tree", mode = { "n", "v" } } -- 切换文件树
        },
        config = true, -- 使用默认配置
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- 这里可以添加你需要的其他选项
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            -- 初始化 nvim-notify
            require("notify").setup()

            -- 设置 noice.nvim
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                cmdline = {
                    view = "cmdline_popup", -- 使用浮动弹窗显示命令行
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%", -- 设置行位置为屏幕中间
                            col = "50%", -- 设置列位置为屏幕中间
                        },
                        size = {
                            width = "auto",
                            height = "auto",
                        },
                    },
                },
            })
        end
    },
    {
        -- which-key.nvim: 显示可用的键位绑定
        "folke/which-key.nvim",
        event = "VeryLazy", -- 延迟加载
        config = true, -- 使用默认配置
    },
    {
        "simrat39/symbols-outline.nvim",
        event = "VeryLazy", -- 延迟加载
        config = true, -- 使用默认配置
    },
    {
        -- mini.ai: 增强的文本对象
        'echasnovski/mini.ai',
        event = "VeryLazy", -- 延迟加载
        config = true, -- 使用默认配置
    },
    {
        -- mini.comment: 注释插件
        "echasnovski/mini.comment",
        event = "VeryLazy", -- 延迟加载
        config = true, -- 使用默认配置
    },
    {
        -- nvim-window-picker: 窗口选择器
        "s1n7ax/nvim-window-picker",
        opts = {
            filter_rules = {
                include_current_win = true, -- 包含当前窗口
                bo = {
                    filetype = { "fidget", "neo-tree" } -- 排除这些文件类型
                }
            }
        },
        keys = {
            {
                "<c-w>p",
                function()
                    local window_number = require('window-picker').pick_window()
                    if window_number then vim.api.nvim_set_current_win(window_number) end
                end,
            } -- 使用 <c-w>p 来选择窗口
        }
    },
}
