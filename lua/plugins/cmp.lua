return {
    -- nvim-cmp: 强大的自动补全插件
    "hrsh7th/nvim-cmp",
    
    -- 指定插件加载的事件，在打开已存在的文件或创建新文件时加载
    event = { "BufReadPost", "BufNewFile" },
    
    -- 声明插件依赖
    dependencies = {
        "hrsh7th/cmp-path",           -- 文件路径补全
        "hrsh7th/cmp-nvim-lsp",       -- LSP 补全
        "hrsh7th/cmp-buffer",         -- 缓冲区补全
        "hrsh7th/cmp-cmdline",        -- 命令行补全
        "saadparwaiz1/cmp_luasnip",   -- LuaSnip 补全
        {
            "saadparwaiz1/cmp_luasnip",
            dependencies = {
                "L3MON4D3/LuaSnip",   -- 代码片段引擎
                dependencies = {
                    "rafamadriz/friendly-snippets",  -- 预定义的代码片段集合
                }
            }
        },
    },
    
    -- 插件配置函数
    config = function()
        -- 检查光标前是否有非空白字符的辅助函数
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -- 加载 VSCode 风格的代码片段
        require("luasnip.loaders.from_vscode").lazy_load()
        local luasnip = require("luasnip")
        local cmp = require 'cmp'

        -- 设置 cmp
        cmp.setup {
            -- 配置代码片段引擎
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            
            -- 配置补全来源
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },  -- LSP
                { name = 'path' },      -- 文件路径
                { name = 'luasnip' },   -- 代码片段
                { name = "buffer" },    -- 缓冲区
            },
            
            -- 配置快捷键
            mapping = cmp.mapping.preset.insert {
                -- Tab 键行为
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Shift+Tab 键行为
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- 回车键确认选中项
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
            
            -- 实验性功能：启用幽灵文本
            experimental = {
                ghost_text = true,
            }
        }

        -- 配置命令行 '/' 搜索补全
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            }
        })

        -- 配置命令行 ':' 命令补全
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' }
            })
        })
    end,
}
