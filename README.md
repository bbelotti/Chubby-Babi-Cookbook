# The Chubby Babi 📖 T

This is the digital version of my recipe book, **The Chubby Babi**: an everlasting effort to maintain and pass down my favorite recipes, and an easy-to-use $\LaTeX$ cookbook template. 

It consists of a main $\LaTeX$ file `cookbook.tex` which, when compiled, will pull all recipes in the specified language (either all English recipes [EN], or all Original Language recipes [OL], to be specified by the user in the `cookbook.tex` preamble) from categorized subfolders. 

This provides an elegant solution to share my recipes with a wider audience of international friends while maintaining the original nature of my cookbook, which currently contains recipes in italian, french, english and german. 

I went for a simple design inspired from the classic $\LaTeX$ style. 

Find a few disclaimers further down.

---

### Using this as a template
This repository may be used as a template by other food and $\LaTeX$ enthusiasts out there :) 

The repo is fully self-contained: simply download the zipped folder using the green `<> Code` button on the top-right of this github repo and extract it somewhere on your computer, then:  

1. **On your computer, in the `recipes/` subfolder:** rename, delete, or add to the existing recipe category folders to fit your own categories — this is where `cookbook.tex` will automatically pull category names from.
1. **On your computer, inside each category folder:** add your own recipes as `EN_*.tex` or `OL_*.tex` files, following the same `\recipe{}` / `ingredients` / `preparation` structure as the examples provided. Keep the `EN_` or `OL_` prefix on every recipe file (e.g. `EN_pizza_napoletana.tex`) — `cookbook.tex` uses this prefix to find and load the correct recipes.
1. **In `cookbook.tex`, only if using multi-language mode:** set `\newcommand{\LangMode}{}` to either `EN` or `OL` to choose which language gets compiled. If you don't need multiple languages, just pick one prefix (`EN` or `OL`), use it consistently, and ignore or delete recipe files with the other prefix. If you do want both languages available, make sure every recipe exists as both an `EN_` and an `OL_` copy — for example, a recipe originally written in English still needs an `OL_` version added, or it will simply be missing whenever you compile in `OL` mode.
1. **In your TeX editor:** open `cookbook.tex`, check that the compilation will be in the language you want by choosing "OL" oe "EN" in the `\newcommand{\LangMode}{EN}` <small>(should be on line 49)</small>, then compile as-is — no other edits needed. The table of contents and category sections (`\part` titles) are generated automatically from whatever folders and files are currently present in `recipes/`. 
1. For everyday additions, renames, or deletions of recipes and categories, nearly all the work happens in the `recipes/` folder on your computer; `cookbook.tex` itself only needs a one-time language setting, if you use that feature. 

---

### Multi-language capabilities
When compiled, the `main.tex` file will iteratively populate the notebook with the recipes in the selected `\LangMode`.Make sure to leave the "EN_" or "OL_" prefixes [e.g., `EN_pizza_napoletana`] to any new recipe you add, or else the main file will not find the associated recipe's `.tex` files. If you do not wish to use the multi-language capability, simply leave the `\newcommand{\LangMode}{}` on either `EN` or `OL`, and ignore all recipes with the other prefix (or delete them, if you want cleaner recipe folders). Instead, if you are using the multi-language capability, in case you have a recipe which original language is in EN, make sure to also add a copy with the `OL_` prefix (or else it will be missing in the OL compilation).

I added a couple of useful `.bat` scripts to quickly list all the recipes included in the folders and their languages, and to perform GIT push/pulls. These will only work on a Windows machine, but are not necessary for the LaTeX project to work.  

The automations within this LaTeX document are made for Windows. If you try to compile this on a Mac, chances are your computer will catch on fire and the universe will explode.

---

### 🛠️ Project Structure

```text
├── cookbook.tex          # Main compilation file (Preamble, layout, category definitions)
├── list_recipes.bat      # Windows tool to instantly check and audit your recipes
├── .gitignore            # Keeps git tracking clean from LaTeX auxiliary files
├── README.md             # The file you're reading right now
├── push_changes.bat      # Double-click to push changes from local machine to current branch
├── pull_changes.bat      # Double-click to pull changes from current branch to local machine
├── fonts                 # Fonts for special characters
└── recipes/              # Subfolders housing individual recipe modules (you can change these!)
    ├── main_courses/
    ├── sauces_and_custards/
    ├── sweets/
    └── list_recipes.bat  # Double-click to show a list of all your recipes and quickly find missing EN or OL versions
```

---

### A note on sourcing

The recipes in this book were transcribed over the years into a personal paper notebook, sometimes from family and friends, sometimes adapted from recipes found online or in other cookbooks. Original sources were not always recorded at the time, and some entries may closely reflect the wording of a recipe I no longer remember the origin of. I don't claim authorship or originality for these recipes.

This project is shared for personal, non-commercial use only — to preserve and pass along mynotebook, not to sell, publish, or claim credit for anyone else's work. If you recognize a recipe as your own or as coming from a specific source, please let me know and I'll gladly add proper attribution.

---

### Compiling this document
Compiling this cookbook requires:
- **XeLaTeX** (not pdfLaTeX) — needed for the custom fonts.
- **Shell escape enabled** (`-shell-escape` / `--enable-write18`, or "Allow restricted execution of external programs" in your editor's settings) — required for the auto-generated table of parts, which scans the `recipes/` folder at compile time via `l3sys-query`.
- A **recent TeX distribution** (2024 or later) — `l3sys-query` and the string-manipulation macros used here rely on an up-to-date LaTeX kernel and `xstring`.
- Run the compiler **twice** for the table of contents and page numbers to resolve correctly.
