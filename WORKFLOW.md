# Hybrid Workflow Guide: Git + Google Drive

This document explains how to use the hybrid workflow that combines Git (for version control) and Google Drive (for collaborative editing).

## Overview

**Git/GitHub**: Source of truth, version control, Markdown files
**Google Drive**: Collaboration, formatting, DOCX files

## Quick Start

### Initial Setup

1. **Install Pandoc** (if not already installed):
   ```bash
   brew install pandoc  # macOS
   ```

2. **Make scripts executable**:
   ```bash
   chmod +x scripts/*.sh
   ```

## Workflow Steps

### Phase 1: Writing in Markdown (Git)

1. Write or edit chapters in Markdown format
2. Commit to Git:
   ```bash
   git add chapters/05-nudge-theory-and-habit-design.md
   git commit -m "Update Chapter 5"
   git push
   ```

### Phase 2: Export to DOCX for Collaboration

1. **Convert Markdown to DOCX**:
   ```bash
   ./scripts/md-to-docx.sh
   ```

2. **Upload to Google Drive**:
   - Go to Google Drive
   - Create a folder: "Cybersecurity Culture Transformed - Book"
   - Upload files from `exports/docx/` folder
   - Organize by chapter

3. **Share with collaborators**:
   - Right-click file → Share
   - Add editors/reviewers
   - Set appropriate permissions

### Phase 3: Collaborate in Google Drive

1. **Edit in Google Docs**:
   - Open DOCX files (they convert to Google Docs format)
   - Use "Suggesting" mode for tracked changes
   - Add comments for discussions
   - Collaborate in real-time

2. **Best Practices**:
   - ✅ Use suggestion mode (not direct editing)
   - ✅ Add comments for questions
   - ✅ Keep formatting simple
   - ✅ Don't delete large sections (use strikethrough)

### Phase 4: Import Back to Markdown

1. **Download edited files**:
   - From Google Drive, download edited DOCX files
   - Save to `exports/docx/` folder

2. **Convert back to Markdown**:
   ```bash
   ./scripts/docx-to-md.sh
   ```
   
   Or for a specific file:
   ```bash
   ./scripts/docx-to-md.sh exports/docx/05-nudge-theory-and-habit-design.docx
   ```

3. **Review changes**:
   - Check converted Markdown files
   - Verify formatting is correct
   - Ensure all content is present
   - Fix any conversion issues

4. **Commit to Git**:
   ```bash
   git add .
   git commit -m "Update from Google Docs collaboration - Chapter 5"
   git push
   ```

## Detailed Workflow Examples

### Example 1: New Chapter Workflow

```bash
# 1. Write new chapter in Markdown
vim chapters/06-leadership-and-modeling.md

# 2. Commit to Git
git add chapters/06-leadership-and-modeling.md
git commit -m "Add Chapter 6: Leadership and Modeling"
git push

# 3. Convert to DOCX
./scripts/md-to-docx.sh

# 4. Upload Chapter-06.docx to Google Drive
# 5. Collaborate with editor
# 6. Download edited file
# 7. Convert back
./scripts/docx-to-md.sh exports/docx/06-leadership-and-modeling.docx

# 8. Review and commit
git diff chapters/06-leadership-and-modeling.md
git add chapters/06-leadership-and-modeling.md
git commit -m "Update Chapter 6 from Google Docs edits"
git push
```

### Example 2: Quick Edit Workflow

For small edits, you might skip Google Drive:

```bash
# Edit directly in Markdown
vim chapters/05-nudge-theory-and-habit-design.md

# Commit directly
git add chapters/05-nudge-theory-and-habit-design.md
git commit -m "Fix typo in Chapter 5"
git push
```

### Example 3: Major Revision Workflow

For major revisions with multiple collaborators:

```bash
# 1. Export current version
./scripts/md-to-docx.sh

# 2. Upload to Google Drive
# 3. Multiple people edit in Google Docs
# 4. Download all edited files
# 5. Convert all back
./scripts/docx-to-md.sh

# 6. Review each file
git diff chapters/

# 7. Commit all changes
git add .
git commit -m "Major revision from Google Docs collaboration"
git push
```

## File Organization

### Git Repository Structure
```
.
├── chapters/           # Markdown source files (version controlled)
├── front-matter/      # Preface, introduction, etc.
├── agent.md          # Writing guide
├── scripts/           # Conversion scripts
└── exports/
    ├── docx/         # DOCX files (not in Git)
    └── backups/      # Automatic backups
```

### Google Drive Structure
```
Cybersecurity Culture Transformed - Book/
├── Chapters/
│   ├── Chapter-01.docx
│   ├── Chapter-02.docx
│   ├── Chapter-03.docx
│   ├── Chapter-04.docx
│   ├── Chapter-05.docx
│   └── Chapter-06.docx (when ready)
├── Full-Manuscript.docx
└── Agent-Guide.docx
```

## Best Practices

### ✅ Do

- Always commit to Git before exporting to DOCX
- Review converted files before committing back to Git
- Use Git for version control and history
- Use Google Drive for collaboration and formatting
- Keep Markdown as the source of truth
- Test converted files before sharing

### ❌ Don't

- Don't edit DOCX files directly in the repository
- Don't skip reviewing converted Markdown files
- Don't delete Git history (it's your backup)
- Don't rely solely on Google Drive (use Git too)
- Don't make major structural changes in Google Docs (do in Markdown)

## Troubleshooting

### Issue: Pandoc not found
**Solution**: Install pandoc using `brew install pandoc` (macOS) or see scripts/README.md

### Issue: Formatting lost in conversion
**Solution**: 
- Review the converted file
- Some complex formatting may need manual adjustment
- Tables and code blocks might need attention

### Issue: Content missing after conversion
**Solution**:
- Check `exports/backups/` for previous versions
- Compare DOCX and Markdown side-by-side
- Re-convert if needed

### Issue: Git conflicts
**Solution**:
- Always pull latest changes before converting
- Review diffs carefully
- Use Git's merge tools if needed

## Tips

1. **Regular Exports**: Export to DOCX regularly, not just at the end
2. **Clear Communication**: Let collaborators know when files are updated
3. **Version Naming**: Consider adding version numbers to DOCX files in Google Drive
4. **Backup Strategy**: Git is your backup - commit often
5. **Test Conversions**: Always test a small file first if unsure

## Getting Help

- Check `scripts/README.md` for script documentation
- Review Git history: `git log`
- Check backups: `exports/backups/`
- Test with a single chapter first

## Summary

**Git = Source of Truth** (Markdown, version control)
**Google Drive = Collaboration** (DOCX, real-time editing)

This hybrid approach gives you the best of both worlds: robust version control from Git and seamless collaboration from Google Drive.

