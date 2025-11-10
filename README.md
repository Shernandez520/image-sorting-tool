# 🖼️ Image Sorting Tool (PowerShell)

This tool automatically sorts images by orientation — **Portrait**, **Landscape**, or **Square** — and logs the results. It’s designed to streamline workflows like Photoshop batch edits that depend on image layout.

## 📂 How to Use

1. **Double-click** `run_sort_images_prompt.bat`
2. When prompted, **paste the full path** to your source image folder (no quotes)
3. The script will:
   - Create subfolders: `1200h` (portrait), `1200w` (landscape), and `Square`
   - Move images based on dimensions
   - Log results in `image_sort_log.txt` inside the source folder
4. Press **Enter** to close the script when finished

## ⚙️ First-Time Setup

If this is your first time running PowerShell scripts, run this command in PowerShell:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned