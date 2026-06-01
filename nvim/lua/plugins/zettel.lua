-- Local plugin. Lives in the config repo for now; to extract into its own
-- GitHub repo later, move the `zettel.nvim/` folder out and replace `dir`
-- with the repo, e.g. `"jszuminski/zettel.nvim"`.
return {
  dir = vim.fn.stdpath("config") .. "/zettel.nvim",
  name = "zettel.nvim",
  cmd = { "Zk", "ZkAtom", "ZkMolecule", "ZkAlloy", "ZkLiterature", "ZkSetReading", "ZkSetTopic", "ZkReading" },
  keys = {
    { "<leader>zz", "<cmd>Zk<cr>", desc = "New note (pick type)" },
    { "<leader>za", "<cmd>ZkAtom<cr>", desc = "New atom" },
    { "<leader>zm", "<cmd>ZkMolecule<cr>", desc = "New molecule" },
    { "<leader>zy", "<cmd>ZkAlloy<cr>", desc = "New alloy" },
    { "<leader>zl", "<cmd>ZkLiterature<cr>", desc = "New literature note" },
    { "<leader>zr", "<cmd>ZkSetReading<cr>", desc = "Set currently reading" },
    { "<leader>zt", "<cmd>ZkSetTopic<cr>", desc = "Set current topic" },
    { "<leader>zo", "<cmd>ZkReading<cr>", desc = "Open currently reading" },
  },
  opts = {
    vault = "~/Documents/jsafe",
    folder = "03. Atoms, molecules, alloys", -- atoms/molecules/alloys share one ID space
    id_separator = ".",
    reading_folder = "02. Literature, Movies, Shows",
    types = {
      atom     = { template = "_templates/1. Atom Template.md" },
      molecule = { template = "_templates/2. Molecule Template.md" },
      alloy    = { template = "_templates/3. Alloy Template.md" },
      literature = {
        template = "_templates/4. Literature Template.md",
        folder = "02. Literature, Movies, Shows", -- its own ID space
        fields = {
          { key = "author", prompt = "Author(s) (comma-separated)", list = true },
          {
            key = "status",
            prompt = "Status",
            type = "select",
            choices = { "currently-reading", "read", "want-to-read", "dnf" },
            default = "currently-reading",
          },
          { key = "pages", prompt = "Pages" },
          { key = "topics", prompt = "Topics (comma-separated)", list = true },
        },
        -- A book marked currently-reading becomes the active currently_reading note.
        set_reading_when = { field = "status", equals = "currently-reading" },
      },
    },
  },
}
