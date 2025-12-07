#!/bin/bash

# DOCX to Markdown Conversion Script
# Converts edited DOCX files back to Markdown for Git version control

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
IMPORT_DIR="$PROJECT_ROOT/exports/docx"
CHAPTERS_DIR="$PROJECT_ROOT/chapters"
BACKUP_DIR="$PROJECT_ROOT/exports/backups"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📝 DOCX to Markdown Converter${NC}"
echo "===================================="

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}❌ Error: pandoc is not installed${NC}"
    echo ""
    echo "Please install pandoc:"
    echo "  macOS: brew install pandoc"
    echo "  Linux: sudo apt-get install pandoc"
    echo "  Windows: choco install pandoc"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"
timestamp=$(date +%Y%m%d_%H%M%S)

# Function to backup existing file
backup_file() {
    local file=$1
    if [ -f "$file" ]; then
        local backup_path="$BACKUP_DIR/$(basename "$file").$timestamp"
        cp "$file" "$backup_path"
        echo -e "    ${YELLOW}📦 Backed up to: $backup_path${NC}"
    fi
}

# Function to convert single file
convert_file() {
    local docx_file=$1
    local output_file=$2
    local filename=$(basename "$docx_file" .docx)
    
    echo ""
    echo -e "${YELLOW}Converting: $filename.docx${NC}"
    
    # Backup existing markdown file
    if [ -f "$output_file" ]; then
        backup_file "$output_file"
    fi
    
    # Convert DOCX to Markdown
    pandoc "$docx_file" \
        -o "$output_file" \
        --wrap=none \
        --extract-media="$PROJECT_ROOT/exports/media" \
        --markdown-headings=atx
    
    if [ $? -eq 0 ]; then
        echo -e "    ${GREEN}✓${NC} Converted to: $output_file"
        echo -e "    ${BLUE}ℹ${NC} Please review the changes before committing to Git"
    else
        echo -e "    ${RED}✗${NC} Failed to convert: $filename.docx"
        return 1
    fi
}

# Check if specific file was provided
if [ $# -eq 1 ]; then
    docx_file="$1"
    if [ ! -f "$docx_file" ]; then
        echo -e "${RED}❌ Error: File not found: $docx_file${NC}"
        exit 1
    fi
    
    # Determine output file
    filename=$(basename "$docx_file" .docx)
    if [[ "$filename" =~ ^[0-9]{2}- ]]; then
        output_file="$CHAPTERS_DIR/$filename.md"
    elif [ "$filename" == "agent" ]; then
        output_file="$PROJECT_ROOT/agent.md"
    else
        echo -e "${RED}❌ Error: Cannot determine output file for: $filename${NC}"
        exit 1
    fi
    
    convert_file "$docx_file" "$output_file"
else
    # Convert all DOCX files in import directory
    echo ""
    echo -e "${YELLOW}Looking for DOCX files in: $IMPORT_DIR${NC}"
    
    found=0
    for docx_file in "$IMPORT_DIR"/*.docx; do
        if [ -f "$docx_file" ]; then
            filename=$(basename "$docx_file" .docx)
            
            # Skip full manuscript
            if [ "$filename" == "Full-Manuscript" ]; then
                continue
            fi
            
            # Determine output file
            if [[ "$filename" =~ ^[0-9]{2}- ]]; then
                output_file="$CHAPTERS_DIR/$filename.md"
            elif [ "$filename" == "agent" ]; then
                output_file="$PROJECT_ROOT/agent.md"
            else
                echo -e "    ${YELLOW}⚠${NC} Skipping: $filename.docx (unknown format)"
                continue
            fi
            
            convert_file "$docx_file" "$output_file"
            found=1
        fi
    done
    
    if [ $found -eq 0 ]; then
        echo -e "${YELLOW}⚠${NC} No DOCX files found in: $IMPORT_DIR"
        echo ""
        echo "Usage:"
        echo "  ./scripts/docx-to-md.sh                    # Convert all files"
        echo "  ./scripts/docx-to-md.sh path/to/file.docx  # Convert specific file"
    fi
fi

echo ""
echo -e "${GREEN}✅ Conversion complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Review the converted Markdown files"
echo "  2. Check for any formatting issues"
echo "  3. Test that the content is correct"
echo "  4. Commit changes to Git: git add . && git commit -m 'Update from Google Docs'"
echo ""
echo "Backups are stored in: $BACKUP_DIR"

