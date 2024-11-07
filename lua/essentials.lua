local option = vim.opt
local buffer = vim.b
local global = vim.g

-- Global Settings --
option.showmode = false -- 关闭编辑模式的显示，避免在状态栏上显示当前模式 (如INSERT, NORMAL等)
option.backspace = { "indent", "eol", "start" } -- 配置退格键的行为，可以删除缩进、行尾和插入开始位置的字符
option.tabstop = 4 -- 将一个tab字符显示为4个空格的宽度
option.shiftwidth = 4 -- 自动缩进时使用4个空格的宽度
option.expandtab = true -- 将tab键插入空格而不是实际的tab字符
option.shiftround = true -- 缩进时，将缩进量四舍五入到shiftwidth的倍数
option.autoindent = true -- 继承当前行的缩进到下一行
option.smartindent = true -- 根据代码语法自动缩进新行
option.number = true -- 显示行号
option.relativenumber = false -- 显示相对行号（当前行号显示为实际行号，其他行显示为相对于当前行的行号）
option.wildmenu = true -- 启用命令行补全增强（类似于IDE的自动补全）
option.hlsearch = false -- 关闭搜索匹配高亮显示
option.ignorecase = true -- 搜索时忽略大小写
option.smartcase = true -- 当搜索模式中包含大写字母时，开启大小写敏感搜索
option.completeopt = { "menu", "menuone" } -- 配置自动补全选项，使补全菜单更友好
option.cursorline = true -- 高亮显示当前行
option.termguicolors = true -- 启用终端的真彩色支持
option.signcolumn = "yes" -- 始终显示标记列
option.autoread = true -- 当文件在外部被修改时，自动重新读取文件
option.title = true -- 显示窗口标题
option.swapfile = false -- 禁用交换文件（swap file）
option.backup = false -- 禁用备份文件
option.updatetime = 50 -- 更改触发事件前的等待时间（以毫秒为单位），默认4000毫秒
option.mouse = "n" -- 启用普通模式下的鼠标支持
option.undofile = true -- 启用持久化撤销
option.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo') -- 设置撤销文件的保存目录
option.exrc = true -- 允许本地vimrc文件
option.wrap = false -- 禁用自动换行
option.splitright = true -- 新建垂直分屏时，将新窗口放在右侧

-- Buffer Settings --
buffer.fileencoding = "utf-8" -- 设置文件编码为UTF-8

-- Global Settings --
global.mapleader = " " -- 设置leader键为空格键

-- Key mappings --
-- vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>") -- 禁用左箭头键
-- vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>") -- 禁用右箭头键
-- vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>") -- 禁用上箭头键
-- vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>") -- 禁用下箭头键

vim.keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>") -- 在普通模式下，按Alt+Tab切换到下一个缓冲区
vim.keymap.set("n", "<leader>bc", "<cmd>bd<CR>") -- 在普通模式下，按leader键加bc关闭当前缓冲区

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- 在可视模式下，将选中内容向下移动一行并重新选中
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- 在可视模式下，将选中内容向上移动一行并重新选中

-- vim.keymap.set({ "v", "n" }, "<leader>y", "\"+y") -- 在可视模式和普通模式下，按leader键加y复制内容到系统剪贴板

-- 按 Ctrl+S 保存文件
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true }) -- 插入模式下ctrl+s 保存并返回到普通模式



