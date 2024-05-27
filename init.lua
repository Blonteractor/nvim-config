vim.opt.relativenumber = true

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('experimental/externalDocs') then
      vim.keymap.set('n', '<leader>od', function()
        client.request('experimental/externalDocs', vim.lsp.util.make_position_params(), function(_, url)
          vim.fn.jobstart(string.format("open %s", url))
        end, vim.api.nvim_get_current_buf())
      end, { noremap = true, silent = true })
    end
  end,
})
