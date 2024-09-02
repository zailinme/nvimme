return {
    -- nvim-lspconfig：用于配置 Neovim 内置的语言服务器协议 (LSP) 客户端
    "neovim/nvim-lspconfig",
    
    -- 指定插件加载的命令
    cmd = { "Mason", "Neoconf" },
    
    -- 指定插件加载的事件，在打开已存在的文件或创建新文件时加载
    event = { "BufReadPost", "BufNewFile" },
    
    -- 声明插件依赖
    dependencies = {
        "williamboman/mason.nvim",          -- 包管理器，用于安装和管理 LSP 服务器、linter 和 formatter
        "williamboman/mason-lspconfig",     -- mason.nvim 和 nvim-lspconfig 的桥接插件
        "folke/neoconf.nvim",               -- 管理全局和项目本地设置
        "folke/neodev.nvim",                -- 为 Neovim Lua API 开发提供完整的签名帮助、文档和补全
        {
            "j-hui/fidget.nvim",            -- 提供 LSP 进度的状态更新
            tag = "legacy",
        },
        "nvimdev/lspsaga.nvim",             -- LSP UI 增强插件
    },
    
    -- 插件配置函数
    config = function()
        -- 定义要使用的 LSP 服务器及其配置
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
            pyright = {},
            jsonls = {},
            -- volar = {},
            bashls = {},
            -- taplo = {},
            clangd = {},
        }

        -- 定义 LSP 附加功能，主要是设置快捷键
        local on_attach = function(_, bufnr)
            -- 启用由 <c-x><c-o> 触发的补全
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end
            
            -- 设置各种 LSP 相关的快捷键
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('gd', require "telescope.builtin".lsp_definitions, '[G]oto [D]efinition')
            nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
            nmap('gi', require "telescope.builtin".lsp_implementations, '[G]oto [I]mplementation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>rn', "<cmd>Lspsaga rename ++project<cr>", '[R]e[n]ame')
            nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')
            nmap('<leader>da', require "telescope.builtin".diagnostics, '[D]i[A]gnostics')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap("<space>f", function()
                vim.lsp.buf.format { async = true }
            end, "[F]ormat code")
        end

        -- 设置各种插件
        require("neoconf").setup()
        require("neodev").setup()
        require("fidget").setup()
        require("lspsaga").setup()
        require("mason").setup()

        -- 获取 nvim-cmp 的 LSP 功能
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- 设置 mason-lspconfig
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
        })

        -- 为每个 LSP 服务器应用配置
        for server, config in pairs(servers) do
            require("lspconfig")[server].setup(
                vim.tbl_deep_extend("keep",
                    {
                        on_attach = on_attach,
                        capabilities = capabilities
                    },
                    config
                )
            )
        end
    end
}
