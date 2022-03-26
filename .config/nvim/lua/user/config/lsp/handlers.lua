local M = {}

M.setup = function()
    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
      -- disable virtual text
      virtual_text = false,
      signs = {
        active = signs,
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      }
    }

    vim.diagnostic.config(config)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    })
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
        [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
            false
        )
    end
end

local function lsp_keymaps(bufnr, client)
    local opts = { noremap = true, silent = true }

    -- vim.cmd [[ command! LspDef 'lua vim.lsp.buf.definition()' ]]
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspDiagSetLocList lua vim.diagnostic.setloclist()")

    vim.cmd [[ command! LspSignatureHelp 'lua vim.lsp.buf.signature_help()' ]]
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":LspDef<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", ":LspCodeAction<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":LspRename<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":LspRefs<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gy", ":LspTypeDef<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":LspHover<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", ":LspDiagPrev<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", ":LspDiagNext<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>d", ":LspDiagLine<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>l", ":LspDiagSetLocList<CR>", opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(
    -- bufnr,
    --     "n",
    --     "gl",
    --     '<cmd>lua vim.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
    --     opts
    -- )
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)

    -- if client.resolved_capabilities.document_formatting then
        -- vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]]
    -- end
    -- vim.cmd "autocmd BufWritePost <buffer> EslintFixAll"
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end

    lsp_keymaps(bufnr, client)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
