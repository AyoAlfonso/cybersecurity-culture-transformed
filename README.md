# Cybersecurity Culture Transformed

A book on transforming cybersecurity culture through behavioral science, nudge theory, and human-centered design.

## Structure

- `chapters/` - All book chapters in Markdown format
- `front-matter/` - Preface, introduction, dedication
- `agent.md` - Writing guide for maintaining style and consistency
- `plans/` - Chapter planning documents

## Writing

Write directly in Markdown (`.md`) files. The repository uses Git for version control.

### Basic Git Workflow

```bash
# After making changes
git add .
git commit -m "Update chapter X"
git push
```

## Converting to DOCX

### Option 1: Markdown → DOCX (Recommended)

**Easiest and most consistent**

Markdown converts cleanly to DOCX using:
- **Pandoc**: `pandoc chapter.md -o chapter.docx`
- **Online tools**: Many free Markdown to DOCX converters
- **VS Code extensions**: "Markdown PDF" or similar

**Pros:**
- ✅ Simple syntax
- ✅ Easy to read and edit
- ✅ Consistent conversion
- ✅ Works well with Git
- ✅ Already using it

**Cons:**
- ⚠️ Complex tables might need adjustment
- ⚠️ Some formatting may need tweaking

### Option 2: LaTeX → DOCX

**More powerful but complex**

LaTeX offers more control but is harder to learn:
- **Pandoc**: `pandoc document.tex -o document.docx`
- More formatting options
- Better for academic papers

**Pros:**
- ✅ Professional typesetting
- ✅ Better for complex documents
- ✅ More formatting control

**Cons:**
- ❌ Steeper learning curve
- ❌ More verbose syntax
- ❌ Harder to read raw files
- ❌ Overkill for most content

## Recommendation

**Stick with Markdown** - You're already using it, it's simpler, and converts well to DOCX when needed. LaTeX is only worth it if you need very specific academic formatting.

## Converting Individual Chapters

When you need DOCX files:

1. **Using Pandoc** (if installed):
   ```bash
   pandoc chapters/05-nudge-theory-and-habit-design.md -o chapter-05.docx
   ```

2. **Online converter**: Upload `.md` file to any Markdown to DOCX converter

3. **Copy/paste**: Copy from Markdown editor, paste into Google Docs

## Notes

- All source files are in Markdown
- Git tracks all changes and history
- Convert to DOCX only when needed for collaboration/formatting
- Markdown remains the source of truth

