# Book Conversion Scripts

Scripts for managing the hybrid workflow between Git (Markdown) and Google Drive (DOCX).

## Prerequisites

### Install Pandoc

**macOS:**
```bash
brew install pandoc
```

**Linux:**
```bash
sudo apt-get install pandoc
```

**Windows:**
```bash
choco install pandoc
```

Or download from: https://pandoc.org/installing.html

### Make Scripts Executable

```bash
chmod +x scripts/*.sh
```

## Scripts

### 1. `md-to-docx.sh` - Convert Markdown to DOCX

Converts all chapter Markdown files to DOCX format for Google Drive collaboration.

**Usage:**
```bash
./scripts/md-to-docx.sh
```

**What it does:**
- Converts all chapters from `chapters/*.md` to `exports/docx/*.docx`
- Converts `agent.md` to `exports/docx/agent.docx`
- Creates a combined `Full-Manuscript.docx` with all chapters

**Output:**
- Individual chapter DOCX files in `exports/docx/`
- Full manuscript DOCX in `exports/docx/Full-Manuscript.docx`

### 2. `docx-to-md.sh` - Convert DOCX back to Markdown

Converts edited DOCX files back to Markdown for Git version control.

**Usage:**
```bash
# Convert all DOCX files in exports/docx/
./scripts/docx-to-md.sh

# Convert a specific file
./scripts/docx-to-md.sh path/to/edited-chapter.docx
```

**What it does:**
- Converts DOCX files back to Markdown
- Automatically backs up existing Markdown files
- Preserves formatting and structure
- Places converted files in the correct locations

**Safety:**
- Creates timestamped backups before overwriting
- Backups stored in `exports/backups/`

## Workflow

### Step 1: Export to DOCX (Git → Google Drive)

1. Make sure your Markdown files are committed to Git
2. Run the conversion script:
   ```bash
   ./scripts/md-to-docx.sh
   ```
3. Upload the DOCX files from `exports/docx/` to Google Drive
4. Share with collaborators for editing

### Step 2: Collaborate in Google Drive

1. Edit files in Google Docs
2. Use comments and suggestions
3. Collaborate in real-time
4. When done, download the edited DOCX files

### Step 3: Import back to Markdown (Google Drive → Git)

1. Download edited DOCX files from Google Drive
2. Place them in `exports/docx/` (or specify path)
3. Run the conversion script:
   ```bash
   ./scripts/docx-to-md.sh
   ```
4. Review the converted Markdown files
5. Commit changes to Git:
   ```bash
   git add .
   git commit -m "Update from Google Docs collaboration"
   git push
   ```

## Best Practices

### Before Converting to DOCX

- ✅ Commit all changes to Git first
- ✅ Ensure Markdown files are clean and properly formatted
- ✅ Run a quick spell check

### During Google Docs Collaboration

- ✅ Use Google Docs' suggestion mode for tracked changes
- ✅ Add comments for questions or discussions
- ✅ Keep formatting simple (let the script handle structure)
- ✅ Don't delete entire sections (use strikethrough if needed)

### After Converting Back to Markdown

- ✅ Always review converted files before committing
- ✅ Check for formatting issues (tables, lists, code blocks)
- ✅ Verify that all content is present
- ✅ Test that the Markdown renders correctly
- ✅ Check backups if something went wrong

## Troubleshooting

### Pandoc not found

Install pandoc using the instructions above, or visit: https://pandoc.org/installing.html

### Formatting issues after conversion

- Tables might need manual adjustment
- Complex formatting may be simplified
- Always review and test converted files

### Lost content

Check the backup directory: `exports/backups/`
Backups are timestamped, so you can recover previous versions.

### Script permissions

If scripts won't run:
```bash
chmod +x scripts/*.sh
```

## File Structure

```
.
├── chapters/              # Markdown source files (Git)
├── exports/
│   ├── docx/             # DOCX files for Google Drive
│   └── backups/          # Timestamped backups
└── scripts/
    ├── md-to-docx.sh     # Export script
    ├── docx-to-md.sh     # Import script
    └── README.md         # This file
```

## Notes

- Git remains the source of truth for content
- DOCX files are for collaboration and formatting
- Always commit to Git after importing from Google Docs
- Keep backups of important versions

