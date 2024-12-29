local M = {}

M.comment_markers = {
  lua = "--",
  python = "#",
  javascript = "//",
  typescript = "//",
  javascriptreact = "//",
  typescriptreact = "//",
  cpp = "//",
  c = "//",
  rust = "//",
  go = "//",
  swift = "//",
  java = "//",
  php = "//",
  vim = '"',
  -- Add more file types as needed
}

function M.toggle_comment()
  -- Get the current filetype and comment marker
  local filetype = vim.bo.filetype
  local comment_marker = M.comment_markers[filetype] or "//"
  local space_after_marker = " "

  -- Get the current visual selection or current line
  local start_line, end_line
  local mode = vim.api.nvim_get_mode().mode

  if mode == "v" or mode == "V" then
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  else
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  -- Check if the first line is commented
  local first_line_content = vim.fn.getline(start_line)
  local is_commented = string.match(first_line_content, "^%s*" .. vim.pesc(comment_marker))

  -- Toggle comments for each line
  for line_num = start_line, end_line do
    local line = vim.fn.getline(line_num)
    local new_line

    if is_commented then
      -- Remove comment
      new_line = string.gsub(line, "^(%s*)" .. vim.pesc(comment_marker) .. "%s?", "%1")
    else
      -- Add comment
      -- Preserve indentation
      local indent = string.match(line, "^%s*")
      new_line = indent .. comment_marker .. space_after_marker .. string.gsub(line, "^%s*", "")
    end

    vim.fn.setline(line_num, new_line)
  end

  -- Reset selection if in visual mode
  if mode == "v" or mode == "V" then
    vim.cmd("normal! gv")
  end
end

return M
