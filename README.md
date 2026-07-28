# The Chubby Babi 📖

This is the digital version of my recipe book, **The Chubby Babi**: an everlasting effort to maintain and pass down my favorite recipes. 

It consists of a main LaTeX file `cookbook.tex` which, when compiled, will pull all recipes in the specified language (either all English recipes [EN], or all Original Language recipes [OL], to be specified by the user in the `cookbook.tex` preamble) from categorized subfolders. 

This provides an elegant solution to share my recipes with a wider audience of international friends while maintaining the original nature of my cookbook, which currently contains recipes in italian, french, english and german. 

I went for a simple design based on the classic LaTeX style. 

Additionally, this may be used as a template by other food and LaTeX enthusiasts out there :) This repository contains everything you need to get started: simply download the folders, then change names/titles/options in the main `cookbook.tex` file, and finally use the individual recipe files in the subfolders as templates to write your recipes (just make sure to leave the "EN_" or "OL_" prefixes [e.g., `EN_pizza_napoletana`], or else the main file will not find the recipe's `.tex` files. Also, if you are using the multi-language capability, in case you have a recipe which original language is in EN, make sure to also add a copy with the `OL_` prefix, or else it will be missing in the OL compilation).  

I added a couple of useful `.bat` scripts to quickly list all the recipes included in the folders and their languages, and to perform GIT push/pulls. These will only work on a Windows machine, but are not necessary for the LaTeX project to work.  

The automations within this LaTeX document are made for Windows. Chances are that the universe will be destroyed if you try to compile this on a Mac.

---

## 🛠️ Project Structure

```text
├── cookbook.tex          # Main compilation file (Preamble, layout, category definitions)
├── list_recipes.bat      # Windows tool to instantly check and audit your recipes
├── .gitignore            # Keeps git tracking clean from LaTeX auxiliary files
├── README.md             # The file you're reading right now
├── push_changes.bat      # Double-click to push changes from local machine to main
├── pull_changes.bat      # Double-click to pull changes from main to local machine
├── fonts                 # Fonts for special chaacters
└── recipes/              # Subfolders housing individual recipe modules
    ├── starters/
    ├── main_courses/
    ├── desserts/
    └── list_recipes.bat  # Double-click to show a list of all your recipes and quickly find missing EN or OL versions
    
