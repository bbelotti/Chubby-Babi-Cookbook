# The Chubby Babi 📖

Welcome to the digital edition of **The Chubby Babi**, a LaTeX cookbook that I use to compile PDFs of recipes in english or in their original language. 
When compiled, the main cookbook.tex file automatically finds all the recipes in the specified language ("EN" for English, or "OL" for Other Language, to be changed in the preamble) that exist in the "recipes" subfolders, and creates the full PDF. 

You can browse my personal recipe collection or reuse this structure as a template for your own culinary notebook, this repository contains everything you need to get started. 

---

## 🛠️ Project Structure

```text
├── cookbook.tex          # Main compilation file (Preamble, layout, category definitions)
├── list_recipes.bat      # Windows tool to instantly check and audit your recipes
├── .gitignore            # Keeps your git tracking clean from LaTeX auxiliary files
├── README.md             # The file you're reading right now
├── push_changes.bat      # Double-click to push changes from local machine to main
├── pull_changes.bat      # Double-click to pull changes from main to local machine
└── recipes/              # Subfolders housing individual recipe modules
    ├── starters/
    ├── main_courses/
    └──  desserts
    
