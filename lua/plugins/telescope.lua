return {
    "nvim-telescope/telescope.nvim",
    -- 定义插件依赖
    dependencies = {
        -- plenary.nvim: Telescope的核心依赖,提供了一些Lua实用函数
        "nvim-lua/plenary.nvim",
        {
            -- telescope-fzf-native.nvim: 提供模糊查找的C实现,提高性能
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make', -- 需要编译
        },
    },
    -- 定义快捷键
    keys = {
        -- 查看最近打开的文件
        { '<leader>?',       "<cmd>lua require('telescope.builtin').oldfiles()<cr>" },
        -- 查看当前打开的缓冲区,按最近使用排序
        { "<leader><space>", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>" },
        -- 在当前缓冲区中进行模糊查找
        { "<leader>/",
            function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,    -- 设置窗口透明度
                    previewer = false, -- 禁用预览窗口
                })
            end
        },
        -- 查找文件
        { '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>" },
        -- 全局搜索(live grep) - 仅搜索 .c, .h, .py, .sh 和 .xml 文件
		{ '<leader>fg', function()
				require('telescope.builtin').live_grep({
					glob_pattern = {"*.c", "*.h", "*.py", "*.sh", "*.xml", "*.lua"}
				})
			end
		},
        -- 搜索帮助标签
        { '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
        -- 列出所有内置pickers
        { '<leader>fp', "<cmd>lua require('telescope.builtin').builtin()<cr>" },
        -- 搜索标记
        { '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>" },
        -- 搜索quickfix列表
        { '<leader>qf', "<cmd>lua require('telescope.builtin').quickfix()<cr>" },
        -- 搜索所有可用的键映射
        { '<leader>km', "<cmd>lua require('telescope.builtin').keymaps()<cr>" },
        -- 搜索可用的命令
        { '<c-p>',      "<cmd>lua require('telescope.builtin').commands()<cr>" },
    },
    -- 插件配置
    config = function()
        require('telescope').setup {
			defaults = {
				file_ignore_patterns = { "compile_commands.json", "%.git/", "%.svn/" , "%.cache/"}, -- 添加文件和目录排除模式
            },
			
            extensions = {
                fzf = {
                    fuzzy = true,                   -- 启用模糊匹配
                    override_generic_sorter = true, -- 使用fzf排序器替换通用排序器
                    override_file_sorter = true,    -- 使用fzf排序器替换文件排序器
                    case_mode = "smart_case",       -- 智能大小写匹配
                }
            }
        }
        -- 加载fzf扩展(目前被注释掉了)
        -- require('telescope').load_extension('fzf')
    end
}



