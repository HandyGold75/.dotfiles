return {
	{
		"kevinhwang91/nvim-ufo",
		name = "nvim-ufo",
		event = { "VeryLazy" },
		dependencies = { "kevinhwang91/promise-async", { "neovim/nvim-lspconfig", name = "lspconfig" } },
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
			local language_servers = require("lspconfig").util.available_servers()
			for _, ls in ipairs(language_servers) do
				require("lspconfig")[ls].setup({ capabilities = capabilities })
			end

			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth) end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype) return { "lsp", "indent" } end,
				fold_virt_text_handler = handler,
			})
		end,
		keys = {
			{ "zR", ":lua require('ufo').openAllFolds()<CR>", mode = { "n" } },
			{ "zM", ":lua require('ufo').closeAllFolds()<CR>", mode = { "n" } },
			{ "zr", ":lua require('ufo').openFoldsExceptKinds()<CR>", mode = { "n" } },
			{ "zm", ":lua require('ufo').closeFoldsWith()<CR>", mode = { "n" } },
			{ "zp", ":lua if not require('ufo').peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end<CR>", mode = { "n" } },
			{ "]z", ":lua require('ufo').goNextClosedFold() require('ufo').peekFoldedLinesUnderCursor()<CR>", mode = { "n" } },
			{ "[z", ":lua require('ufo').goPreviousClosedFold() require('ufo').peekFoldedLinesUnderCursor()<CR>", mode = { "n" } },
		},
	},
}
