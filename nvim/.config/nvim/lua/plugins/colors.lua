return {
  "navarasu/onedark.nvim",
  opts = {
    style = "darker",
  },
  config = function()
    require("onedark").load()
  end,
}
