return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({ PATH = "prepend" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "fortls", "bashls", "omnisharp", "lua_ls", "gopls", "templ",
          "html", "cssls", "emmet_ls", "tailwindcss", "ols",
          "clangd", "yamlls", "jsonls", "eslint", "marksman",
          "sqlls", "wgsl_analyzer", "texlab", "intelephense", "nim_langserver"
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local function setup(server, opts)
        vim.lsp.config(server, vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, opts or {}))
        vim.lsp.enable(server)
      end

      -- Lua
      setup("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
                "${3rd}/love2d/library"
              }
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Other servers
      setup("bashls")
      setup("gopls")
      setup("cmake")
      setup("astro")
      setup("fortls", {
        root_dir = vim.fs.dirname(vim.fs.find({ "*.f90" }, { upward = true })[1]),
      })
      setup("jsonls")
      setup("yamlls")
      setup("cssls")
      setup("html")
      setup("emmet_ls", {
        filetypes = { "html", "css", "javascriptreact", "typescriptreact", "templ" },
      })
      setup("tailwindcss")
      setup("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--pch-storage=memory",
          "--all-scopes-completion",
          "--header-insertion=never",
        },
      })
      setup("pylsp", {
        settings = {
          python = {
            pythonPath = (function()
              local venv = os.getenv("VIRTUAL_ENV")
              if venv then return venv .. "/bin/python" end
              return vim.loop.os_uname().sysname == "Windows_NT"
                  and "C:/python312"
                  or "/usr/bin/python3"
            end)(),
          },
        },
      })
      setup("omnisharp", { cmd = { "OmniSharp" } })
      setup("texlab")
      setup("intelephense")
      setup("marksman")
      setup("nim_langserver")
      setup("wgsl_analyzer")
      -- setup("prismals")
    end,
  },

  -- 🔥 TypeScript tools (instead of plain tsserver)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      -- You can add tsserver-specific options here
      on_attach = function(client, bufnr)
        -- Example: disable tsserver formatting in favor of prettier/biome
        client.server_capabilities.documentFormattingProvider = false
      end,
      settings = {
        -- Example settings
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
        },
      },
    },
  },
}
