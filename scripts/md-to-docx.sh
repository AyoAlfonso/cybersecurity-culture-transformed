#!/bin/bash

# Markdown to DOCX Conversion Script
# Converts all chapter Markdown files to DOCX format for Google Drive collaboration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
EXPORT_DIR="$PROJECT_ROOT/exports/docx"
CHAPTERS_DIR="$PROJECT_ROOT/chapters"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}📄 Markdown to DOCX Converter${NC}"
echo "=================================="

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}❌ Error: pandoc is not installed${NC}"
    echo ""
    echo "Please install pandoc:"
    echo "  macOS: brew install pandoc"
    echo "  Linux: sudo apt-get install pandoc"
    echo "  Windows: choco install pandoc"
    echo ""
    echo "Or visit: https://pandoc.org/installing.html"
    exit 1
fi

# Create export directory if it doesn't exist
mkdir -p "$EXPORT_DIR"

# Convert each chapter
echo ""
echo -e "${YELLOW}Converting chapters...${NC}"

for md_file in "$CHAPTERS_DIR"/*.md; do
    if [ -f "$md_file" ]; then
        filename=$(basename "$md_file" .md)
        docx_file="$EXPORT_DIR/${filename}.docx"
        
        echo "  → Converting: $filename.md"
        
        pandoc "$md_file" \
            -o "$docx_file" \
            --reference-doc="$PROJECT_ROOT/scripts/reference.docx" 2>/dev/null || \
        pandoc "$md_file" \
            -o "$docx_file" \
            --standalone \
            --toc \
            --toc-depth=2 \
            -V geometry:margin=1in \
            -V fontsize=11pt \
            -V linestretch=1.5
        
        if [ $? -eq 0 ]; then
            echo -e "    ${GREEN}✓${NC} Created: $docx_file"
        else
            echo -e "    ${RED}✗${NC} Failed to convert: $filename.md"
        fi
    fi
done

# Convert agent.md if it exists
if [ -f "$PROJECT_ROOT/agent.md" ]; then
    echo "  → Converting: agent.md"
    pandoc "$PROJECT_ROOT/agent.md" \
        -o "$EXPORT_DIR/agent.docx" \
        --standalone
    echo -e "    ${GREEN}✓${NC} Created: exports/docx/agent.docx"
fi

# Create combined manuscript (optional)
echo ""
echo -e "${YELLOW}Creating combined manuscript...${NC}"
combined_file="$EXPORT_DIR/Full-Manuscript.docx"

# Get all chapters in order
chapters=(
    "$CHAPTERS_DIR/01-why-security-culture-matters.md"
    "$CHAPTERS_DIR/02-beyond-awareness-campaigns.md"
    "$CHAPTERS_DIR/03-diagnosing-your-current-culture.md"
    "$CHAPTERS_DIR/04-the-psychology-of-risk.md"
    "$CHAPTERS_DIR/05-nudge-theory-and-habit-design.md"
)

# Create temporary combined file
temp_combined=$(mktemp)
for chapter in "${chapters[@]}"; do
    if [ -f "$chapter" ]; then
        cat "$chapter" >> "$temp_combined"
        echo "" >> "$temp_combined"
        echo "---" >> "$temp_combined"
        echo "" >> "$temp_combined"
    fi
done

pandoc "$temp_combined" \
    -o "$combined_file" \
    --standalone \
    --toc \
    --toc-depth=2 \
    -V geometry:margin=1in \
    -V fontsize=11pt \
    -V linestretch=1.5

rm "$temp_combined"

if [ $? -eq 0 ]; then
    echo -e "    ${GREEN}✓${NC} Created: exports/docx/Full-Manuscript.docx"
else
    echo -e "    ${YELLOW}⚠${NC} Could not create combined manuscript"
fi

echo ""
echo -e "${GREEN}✅ Conversion complete!${NC}"
echo ""
echo "Files are ready in: $EXPORT_DIR"
echo "You can now upload these to Google Drive for collaboration."

