return {
    "nvim-treesitter/nvim-treesitter",
    -- 依赖插件
    dependencies = {
        "nvim-treesitter/playground",           -- 用于调试和开发 Treesitter 查询
        "nvim-treesitter/nvim-treesitter-textobjects", -- 提供基于 Treesitter 的文本对象
    },
    main = "nvim-treesitter.configs",  -- 主模块
    build = ":TSUpdate",               -- 安装或更新时运行的命令
    opts = {
        -- 确保安装的语言解析器
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", },
        
        -- 启用语法高亮
        highlight = {
            enable = true,
        },
        
        -- 启用缩进
        indent = {
            enable = true,
        },
        
        -- 启用 Treesitter Playground
        playground = {
            enable = true,
        },
        
        -- 启用增量选择
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<CR>',    -- 初始化选择
                node_incremental = '<CR>',  -- 增加选择范围
                node_decremental = '<BS>',  -- 减少选择范围
                scope_incremental = '<TAB>', -- 选择父节点
            }
        },
        
        -- 文本对象设置
        textobjects = {
            select = {
                enable = true,
                lookahead = true,  -- 自动跳转到文本对象，类似于 targets.vim
                keymaps = {
                    -- 可以使用 textobjects.scm 中定义的捕获组
                    ["af"] = "@function.outer",  -- 选择函数外部
                    ["if"] = "@function.inner",  -- 选择函数内部
                    ["ac"] = "@class.outer",     -- 选择类外部
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" }, -- 选择类内部
                    ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" }, -- 选择语言作用域
                },
                -- 可以选择选择模式（默认是字符模式 'v'）
                selection_modes = {
                    ['@parameter.outer'] = 'v',   -- 字符模式
                    ['@function.outer'] = 'V',    -- 行模式
                    ['@class.outer'] = '<c-v>',   -- 块模式
                },
                -- 是否包含周围的空白字符
                include_surrounding_whitespace = false,
            },
        },
    },
}
