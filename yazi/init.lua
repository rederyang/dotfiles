th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()
th.git = th.git or {}
th.git.unknown_sign = " "
th.git.modified_sign = "M"
th.git.deleted_sign = "D"

require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
