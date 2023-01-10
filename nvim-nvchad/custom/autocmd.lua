------------------------------------
-- 自動命令
------------------
---@diagnostic disable: lowercase-global, undefined-global

-- https://zhuanlan.zhihu.com/p/557199534

-- BufWinEnter（创建默认窗口）
-- BufEnter（创建默认缓冲区）
-- VimEnter（启动 Vim 会话）：编辑 demo.txt
-- BufNew（创建一个新缓冲区以包含 demo.txt）
-- BufAdd（将新缓冲区添加到会话的缓冲区列表中）
-- BufLeave（退出默认缓冲区）
-- BufWinLeave（退出默认窗口）
-- BufUnload（从缓冲区列表中删除默认缓冲区）
-- BufDelete（取消分配默认缓冲区）
-- BufReadCmd（将 demo.txt 的上下文读入新缓冲区）
-- BufEnter（激活新缓冲区）
-- BufWinEnter（激活新缓冲区的窗口）i
-- InsertEnter（切换到插入模式）


-- local autocmd = vim.api.nvim_create_autocmd
--
-- -- BufNewFile : 编辑一个不存在的文件时 (:e xxx)
-- -- BufRead    : 第一次读取buf时
-- autocmd({ "BufNewFile", "BufRead" }, {
--    callback = function(ctx)
--       print("test... - " .. ctx.id)
--    end,
-- })

