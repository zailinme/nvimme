return {
    -- null-ls.nvim 插件，用于为 Neovim 提供语言服务器协议 (LSP) 诊断、代码操作和格式化
    "jose-elias-alvarez/null-ls.nvim",
    
    -- 指定插件加载的事件，在打开已存在的文件或创建新文件时加载
    event = { "BufReadPost", "BufNewFile" },
    
    -- 声明插件依赖
    dependencies = {
        -- mason-null-ls.nvim 用于自动安装和管理 null-ls 所需的工具
        "jay-babu/mason-null-ls.nvim",
    },
    
    -- 插件配置函数
    config = function()
        -- 定义需要安装的工具列表
        -- local tools = {
          --  "black", -- Python 代码格式化工具
        -- }
        
        -- 设置 mason-null-ls
        require("mason-null-ls").setup({
            ensure_installed = tools, -- 确保安装上面定义的工具
            handlers = {}, -- 可以添加自定义处理程序，这里暂时为空
        })
        
        -- 设置 null-ls
        require("null-ls").setup({
            sources = {}, -- 可以在这里添加 null-ls 的源，这里暂时为空
        })
    end
}
