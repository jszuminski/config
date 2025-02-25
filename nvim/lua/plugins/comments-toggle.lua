return {
    'numToStr/Comment.nvim',
    event = "BufReadPost",  -- or use another event if you prefer
    config = function()
      require("Comment").setup({
        -- add your custom configuration here, if desired
      })
    end
}
