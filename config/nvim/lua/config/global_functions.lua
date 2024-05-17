function RUN_COMMAND_IN_NEW_BUFFER()
	local command = vim.fn.input("Command: ")
	vim.cmd("new")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "hide"
	vim.bo.swapfile = false
	vim.cmd("read !" .. command)
end
