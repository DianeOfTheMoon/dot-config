local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local lsp_status = require('lsp-status')
local dap = require('dap')

lsp_status.register_progress()


--config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

vim.g.vista_default_executive = 'nvim_lsp'
vim.g.dap_virtual_text = true


local on_attach = function(client, bufnr)
    lsp_status.on_attach(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gE', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'ge', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'gj', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', 'f', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<tab>', '<cmd>Vista finder<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_exec([[
      augroup lsp_autoformat
        autocmd!
        autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
      augroup END
    ]], false)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      :hi link LspReferenceRead IncSearch
      :hi link LspReferenceText WildMenu
      :hi link LspReferenceWrite QuickFixLine
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

vim.fn.sign_define("LspDiagnosticsSignHint", {text=" ", texthl='LspDiagnosticsSignHint', linehl=nil, numhl=nil})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text=" ", texthl='LspDiagnosticsSignInformation', linehl=nil, numhl=nil})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text=" ", texthl='LspDiagnosticsSignWarning', linehl=nil, numhl=nil})
vim.fn.sign_define("LspDiagnosticsSignError", {text=" ", texthl='LspDiagnosticsSignError', linehl=nil, numhl=nil})

vim.highlight.link('LspDiagnosticsSignHint', 'Type', true)
vim.highlight.link('LspDiagnosticsSignInformation', 'Question', true)
vim.highlight.link('LspDiagnosticsSignWarning', 'WarningMsg', true)
vim.highlight.link('LspDiagnosticsSignError', 'ErrorMsg', true)

vim.highlight.link('LspDiagnosticsDefaultError', 'ErrorMsg', true)
vim.highlight.link('LspDiagnosticsDefaultWarning', 'WarningMsg', true)
vim.highlight.link('LspDiagnosticsDefaultInformation', 'Question', true)
vim.highlight.link('LspDiagnosticsDefaultHint', 'Type', true)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local pid = vim.fn.getpid()
local omnisharp_bin = '/Users/diane/bin/omnisharp'

lspconfig.omnisharp.setup{
    capabilities = capabilities;
    cmd = {omnisharp_bin, "--hostPID", tostring(pid), "--languageserver"};
    root_dir = function() return "/Users/diane/Projects/murder-doggo" end;
    on_attach = on_attach;
}
lspconfig.gopls.setup{
    on_attach = on_attach;
    capabilities = capabilities;
}
lspconfig.tsserver.setup{}



dap.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err =
      vim.loop.spawn(
      "dlv",
      {
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
      },
      function(code)
        handle:close()
        print("Delve exited with exit code: " .. code)
      end
    )
    -- Wait 100ms for delve to start
    vim.defer_fn(
      function()
        --dap.repl.open()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
      100)


    --callback({type = "server", host = "127.0.0.1", port = port})
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}"
    },
}
