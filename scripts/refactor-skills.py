#!/usr/bin/env python3
"""
Refactor all SKILL.md files:
1. Remove ## Agent Compatibility section (already in references/compatibility-matrix.md)
2. Move ## Time Saved content to references/README.md
3. Remove standalone ## Complexity Level section (already in frontmatter)
4. Standardize ## Examples to use @examples/input.md + @examples/output.md
"""

import os
import re
import glob

SKILLS_SRC = os.path.join(os.path.dirname(__file__), '..', '.agents', 'skills-src')

def get_all_skill_mds():
    return glob.glob(os.path.join(SKILLS_SRC, '*', '*', 'SKILL.md'))

def remove_section(content, heading):
    """Remove a ## section and all its content until the next ## section."""
    pattern = rf'\n## {re.escape(heading)}\n.*?(?=\n## |\Z)'
    return re.sub(pattern, '', content, flags=re.DOTALL)

def get_section_content(content, heading):
    """Extract content of a ## section."""
    pattern = rf'\n## {re.escape(heading)}\n(.*?)(?=\n## |\Z)'
    m = re.search(pattern, content, re.DOTALL)
    return m.group(1).strip() if m else None

def update_references_readme(readme_path, skill_name, time_saved_content):
    """Add Time Saved to references/README.md."""
    with open(readme_path, 'r') as f:
        content = f.read()

    # Add Time Saved section if not already present
    if '## Time Saved' not in content:
        content = content.rstrip() + f'\n\n## Time Saved\n{time_saved_content}\n'
        with open(readme_path, 'w') as f:
            f.write(content)

def standardize_examples_section(content):
    """Replace prose examples link with @examples directives."""
    old = r'## Examples\nSee \[examples/\]\(examples/\)[^\n]*\n'
    new = '## Examples\n\n@examples/input.md\n@examples/output.md\n'
    return re.sub(old, new, content)

def refactor_skill(skill_md_path):
    skill_dir = os.path.dirname(skill_md_path)
    skill_name = os.path.basename(skill_dir)
    references_dir = os.path.join(skill_dir, 'references')
    readme_path = os.path.join(references_dir, 'README.md')

    with open(skill_md_path, 'r') as f:
        content = f.read()

    original = content

    # 1. Extract Time Saved before removing it
    time_saved = get_section_content(content, 'Time Saved')

    # 2. Update references/README.md with Time Saved
    if time_saved and os.path.exists(readme_path):
        update_references_readme(readme_path, skill_name, time_saved)

    # 3. Remove ## Agent Compatibility section
    content = remove_section(content, 'Agent Compatibility')

    # 4. Remove ## Time Saved section
    content = remove_section(content, 'Time Saved')

    # 5. Remove standalone ## Complexity Level section
    content = remove_section(content, 'Complexity Level')

    # 6. Standardize ## Examples section
    content = standardize_examples_section(content)

    # Clean up any double blank lines left behind
    content = re.sub(r'\n{3,}', '\n\n', content)

    if content != original:
        with open(skill_md_path, 'w') as f:
            f.write(content)
        return True
    return False

def main():
    skills = get_all_skill_mds()
    updated = 0
    for path in sorted(skills):
        if refactor_skill(path):
            rel = path.replace(SKILLS_SRC + '/', '')
            print(f'  ✓ {rel}')
            updated += 1
    print(f'\nDone. {updated}/{len(skills)} SKILL.md files updated.')

if __name__ == '__main__':
    main()
