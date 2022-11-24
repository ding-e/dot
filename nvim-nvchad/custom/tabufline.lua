local api = vim.api
local function getNvimTreeWidth()
   for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
      if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
         return api.nvim_win_get_width(win) + 1
      end
   end
   return 0
end

return {
   CoverNvimTree = function()
      return "%#NvimTreeNormal#"
      -- return "%#NvimTreeEndOfBuffer#"
         .. (vim.g.nvimtree_side == "right" and "" or string.rep(" ", getNvimTreeWidth()))
   end,
}
