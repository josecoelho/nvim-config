local config = {
  providers = {
    openai = {
      disable = false,
      endpoint = "https://api.openai.com/v1/chat/completions",
      -- secret = os.getenv("OPENAI_API_KEY"),
    },
    azure = {
      disable = true,
      endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions",
      secret = os.getenv "AZURE_API_KEY",
    },
    copilot = {
      disable = true,
      endpoint = "https://api.githubcopilot.com/chat/completions",
      secret = {
        "bash",
        "-c",
        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
      },
    },
    ollama = {
      disable = true,
      endpoint = "http://localhost:11434/v1/chat/completions",
      secret = "dummy_secret",
    },
    lmstudio = {
      disable = true,
      endpoint = "http://localhost:1234/v1/chat/completions",
      secret = "dummy_secret",
    },
    googleai = {
      disable = true,
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
      secret = os.getenv "GOOGLEAI_API_KEY",
    },
    pplx = {
      disable = true,
      endpoint = "https://api.perplexity.ai/chat/completions",
      secret = os.getenv "PPLX_API_KEY",
    },
    anthropic = {
      disable = false,
      endpoint = "https://api.anthropic.com/v1/messages",
      secret = os.getenv "ANTHROPIC_API_KEY",
    },
  },
  agents = {
    {
      provider = "anthropic",
      name = "ChatClaude-3-Haiku",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
  },
}

require("gp").setup(config)

-- shortcuts
--
local function keymapOptions(desc)
  return {
    noremap = true,
    silent = true,
    nowait = true,
    desc = "GPT prompt " .. desc,
  }
end

-- Chat commands
vim.keymap.set({ "n", "i" }, "<leader>gc", "<cmd>GpChatNew<cr>", keymapOptions "New Chat")
vim.keymap.set({ "n", "i" }, "<leader>gt", "<cmd>GpChatToggle<cr>", keymapOptions "Toggle Chat")
vim.keymap.set({ "n", "i" }, "<leader>gf", "<cmd>GpChatFinder<cr>", keymapOptions "Chat Finder")

vim.keymap.set("v", "<leader>gc", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions "Visual Chat New")
vim.keymap.set("v", "<leader>gp", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions "Visual Chat Paste")
vim.keymap.set("v", "<leader>gt", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions "Visual Toggle Chat")

vim.keymap.set({ "n", "i" }, "<leader>g<C-x>", "<cmd>GpChatNew split<cr>", keymapOptions "New Chat split")
vim.keymap.set({ "n", "i" }, "<leader>g<C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions "New Chat vsplit")
vim.keymap.set({ "n", "i" }, "<leader>g<C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions "New Chat tabnew")

vim.keymap.set("v", "<leader>g<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions "Visual Chat New split")
vim.keymap.set("v", "<leader>g<C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions "Visual Chat New vsplit")
vim.keymap.set("v", "<leader>g<C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions "Visual Chat New tabnew")

-- Prompt commands
vim.keymap.set({ "n", "i" }, "<leader>gr", "<cmd>GpRewrite<cr>", keymapOptions "Inline Rewrite")
vim.keymap.set({ "n", "i" }, "<leader>ga", "<cmd>GpAppend<cr>", keymapOptions "Append (after)")
vim.keymap.set({ "n", "i" }, "<leader>gb", "<cmd>GpPrepend<cr>", keymapOptions "Prepend (before)")

vim.keymap.set("v", "<leader>gr", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions "Visual Rewrite")
vim.keymap.set("v", "<leader>ga", ":<C-u>'<,'>GpAppend<cr>", keymapOptions "Visual Append (after)")
vim.keymap.set("v", "<leader>gb", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions "Visual Prepend (before)")
vim.keymap.set("v", "<leader>gi", ":<C-u>'<,'>GpImplement<cr>", keymapOptions "Implement selection")

vim.keymap.set({ "n", "i" }, "<leader>ggp", "<cmd>GpPopup<cr>", keymapOptions "Popup")
vim.keymap.set({ "n", "i" }, "<leader>gge", "<cmd>GpEnew<cr>", keymapOptions "GpEnew")
vim.keymap.set({ "n", "i" }, "<leader>ggn", "<cmd>GpNew<cr>", keymapOptions "GpNew")
vim.keymap.set({ "n", "i" }, "<leader>ggv", "<cmd>GpVnew<cr>", keymapOptions "GpVnew")
vim.keymap.set({ "n", "i" }, "<leader>ggt", "<cmd>GpTabnew<cr>", keymapOptions "GpTabnew")

vim.keymap.set("v", "<leader>ggp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions "Visual Popup")
vim.keymap.set("v", "<leader>gge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions "Visual GpEnew")
vim.keymap.set("v", "<leader>ggn", ":<C-u>'<,'>GpNew<cr>", keymapOptions "Visual GpNew")
vim.keymap.set("v", "<leader>ggv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions "Visual GpVnew")
vim.keymap.set("v", "<leader>ggt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions "Visual GpTabnew")

vim.keymap.set({ "n", "i" }, "<leader>gx", "<cmd>GpContext<cr>", keymapOptions "Toggle Context")
vim.keymap.set("v", "<leader>gx", ":<C-u>'<,'>GpContext<cr>", keymapOptions "Visual Toggle Context")

vim.keymap.set({ "n", "i", "v", "x" }, "<leader>gs", "<cmd>GpStop<cr>", keymapOptions "Stop")
vim.keymap.set({ "n", "i", "v", "x" }, "<leader>gn", "<cmd>GpNextAgent<cr>", keymapOptions "Next Agent")
