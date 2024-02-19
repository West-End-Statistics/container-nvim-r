return {
  {"jalvesaq/Nvim-R",
  lazy = false,
  },
  config = function()
	vim.cmd([[
	let R_app = "radian"
	let R_hl_term = 0
	let R_args = []
	let R_bracketed_paste = 1
	]])
end},

}
