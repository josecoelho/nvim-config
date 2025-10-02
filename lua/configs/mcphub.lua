require("mcphub").setup {
  -- Required options
  port = 9898, -- Port for MCP Hub server
  config = vim.fn.expand "~/.config/mcpservers.json", -- Absolute path to config file
  extensions = {
    avante = {
      make_slash_commands = true, -- make /slash commands from MCP server prompts
    },
  },

  -- Optional options
  on_ready = function(hub)
    -- Called when hub is ready
  end,
  on_error = function(err)
    -- Called on errors
  end,
  log = {
    level = vim.log.levels.WARN,
    to_file = false,
    file_path = nil,
    prefix = "MCPHub",
  },
}
