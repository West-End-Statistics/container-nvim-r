return {
  {"jalvesaq/Nvim-R",
  lazy = false,
  
  config = function() 
	vim.cmd([[
	let R_app = "radian"
  let R_cmd = 'R'
	let R_hl_term = 0
	let R_args = []
	let R_bracketed_paste = 1
	]])
end
},
  {
    	"hrsh7th/nvim-cmp",
      dependencies = {
        "jalvesaq/cmp-nvim-r",
        "hrsh7th/nvim-cmp",
        "onsails/lspkind.nvim"
      },
      lazy = false,
      config = function()
        local cmp = require("cmp")
        local lspkind = require('lspkind')


        cmp.setup {
    mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = {
            i = cmp.mapping.confirm({ select = true }),
    },
    }),


              formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- the truncated part when popup menu exceed maxwidth
            before = function(entry, item)
                local menu_icon = {
                    nvim_lsp = '',
                    vsnip = '',
                    path = '',
                    --cmp_zotcite = 'z',
                    cmp_nvim_r = 'R'
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        })

          
      },
      sources = {
    { name = 'cmp_nvim_r' },
    { name = 'path', option = { trailing_slash = true } },
    { name = 'nvim_lsp' },
  }
}
        require("cmp_nvim_r").setup({
  filetypes = {"r", "rmd", "quarto", "rhelp"},
  doc_width = 58
  })


      end

  }



}
