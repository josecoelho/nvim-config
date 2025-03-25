-- Avante configuration
local M = {}

-- Configuration options for the Avante plugin
M.options = {
  ---@alias Avante.Provider "claude" | "openai" | "azure" | "gemini" | "vertex" | "cohere" | "copilot" | string
  provider = "openai", -- Using OpenAI
  auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  file_selector = {
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
    provider = "telescope",
    -- Options override for custom providers, currently only works with fzf and telescope
    -- provider_opts = {},
  },
  web_search_engine = {
    provider = "tavily", -- tavily, serpapi, searchapi, google or kagi
  },
  openai = {
    endpoint = "https://api.openai.com",
    model = "gpt-4o", -- Latest and most capable model
    timeout = 30000, -- Timeout in milliseconds
    temperature = 0.1, -- Slightly higher than 0 for more creative responses while maintaining accuracy
    max_tokens = 4000, -- Adjusted for OpenAI's context window
    tools_enabled = false, -- keep only mcp tools
  },
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet-20250219",
    timeout = 30000, -- Timeout in milliseconds
    temperature = 0,
    max_tokens = 8000,
    disable_tools = true, -- Disable tools for now (it's enabled by default) as it's causing rate-limit problems with Claude, see more here: https://github.com/yetone/avante.nvim/issues/1384
  },
  -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    if hub then
      return hub:get_active_servers_prompt()
    end
  end,
  -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
}

-- Setup function to initialize Avante
M.setup = function()
  require("avante").setup(M.options)
end

return M
