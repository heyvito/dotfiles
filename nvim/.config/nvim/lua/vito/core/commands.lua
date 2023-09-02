local is_neotree_focused = function()
    -- Get our current buffer number
    local bufnr = vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or vim.fn.bufnr()
    -- Get all the available sources in neo-tree
    for _, source in ipairs(require("neo-tree").config.sources) do
        -- Get each sources state
        local state = require("neo-tree.sources.manager").get_state(source)
        -- Check if the source has a state, if the state has a buffer and if the buffer is our current buffer
        if state and state.bufnr and state.bufnr == bufnr then
            return true
        end
    end
    return false
end

local function is_neotree_open()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'ft') == 'neo-tree' then
      return true
    end
  end
  return false
end

vim.api.nvim_create_user_command(
  'VToggleTree',
  function()
    if is_neotree_focused() then
      vim.cmd('Neotree close')
    elseif is_neotree_open() then
      vim.cmd('Neotree focus')
    else
      vim.cmd('Neotree')
    end
  end, {})

vim.api.nvim_create_user_command(
  'VShowHideTree',
  function()
    if is_neotree_open() then
      vim.cmd('Neotree close')
    else
      vim.cmd('Neotree show')
    end
  end, {})

