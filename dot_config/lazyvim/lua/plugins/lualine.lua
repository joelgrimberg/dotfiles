return {
  priority = 1000,
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {
        format = function(client_messages)
          local api = require("lsp-progress.api")
          local lsp_clients = #api.lsp_clients()
          if #client_messages > 0 then
            return table.concat(client_messages, " ")
          elseif lsp_clients > 0 then
            return "󰄳 LSP " .. lsp_clients .. " clients"
          end
          return ""
        end,
      },
    },
  },
}
