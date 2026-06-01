-- Local plugin. Lives in the config repo for now; to extract into its own
-- GitHub repo later, move the `zettel.nvim/` folder out and replace `dir`
-- with the repo, e.g. `"jszuminski/zettel.nvim"`.
return {
  dir = vim.fn.stdpath("config") .. "/zettel.nvim",
  name = "zettel.nvim",
  cmd = { "Zk", "ZkAtom", "ZkMolecule", "ZkAlloy" },
  keys = {
    { "<leader>zz", "<cmd>Zk<cr>", desc = "New note (pick type)" },
    { "<leader>za", "<cmd>ZkAtom<cr>", desc = "New atom" },
    { "<leader>zm", "<cmd>ZkMolecule<cr>", desc = "New molecule" },
    { "<leader>zy", "<cmd>ZkAlloy<cr>", desc = "New alloy" },
  },
  opts = {
    vault = "~/Documents/jsafe",
    folder = "03. Atoms, molecules, alloys", -- atoms/molecules/alloys share one ID space
    id_separator = ".",
    types = {
      atom     = { template = "_templates/1. Atom Template.md" },
      molecule = { template = "_templates/2. Molecule Template.md" },
      alloy    = { template = "_templates/3. Alloy Template.md" },
    },
  },
}
