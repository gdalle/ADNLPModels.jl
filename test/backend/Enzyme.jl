using ADNLPModels, Enzyme

include("utils.jl")

test_adbackend(:Enzyme)

# list_excluded_enzyme = [
#   "brybnd",
#   "clplatea",
#   "clplateb",
#   "clplatec",
#   "curly",
#   "curly10",
#   "curly20",
#   "curly30",
#   "elec",
#   "fminsrf2",
#   "hs101",
#   "hs117",
#   "hs119",
#   "hs86",
#   "integreq",
#   "ncb20",
#   "ncb20b",
#   "palmer1c",
#   "palmer1d",
#   "palmer2c",
#   "palmer3c",
#   "palmer4c",
#   "palmer5c",
#   "palmer5d",
#   "palmer6c",
#   "palmer7c",
#   "palmer8c",
#   "sbrybnd",
#   "tetra",
#   "tetra_duct12",
#   "tetra_duct15",
#   "tetra_duct20",
#   "tetra_foam5",
#   "tetra_gear",
#   "tetra_hook",
#   "threepk",
#   "triangle",
#   "triangle_deer",
#   "triangle_pacman",
#   "triangle_turtle",
#   "watson",
# ]
