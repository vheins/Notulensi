#!/usr/bin/env python3
"""
Safely migrates ## Example Usage sections from SKILL.md to examples/input.md + examples/output.md.
Only modifies files that still have ## Example Usage (not already migrated).
Preserves all other content exactly as-is.
"""
import os
import re

SKILLS_DIR = "/home/kali/vibe-coding-premium/.agents/skills"

REFERENCE = "## Examples\n\nSee [`examples/`](examples/) for concrete input/output examples.\n"


def migrate(skill_md_path):
    with open(skill_md_path, 'r') as f:
        content = f.read()

    # Find ## Example Usage section boundaries
    start = re.search(r'^## Example Usage\n', content, re.MULTILINE)
    if not start:
        return False

    # Find the next ## section after Example Usage
    end = re.search(r'^## ', content[start.end():], re.MULTILINE)
    if end:
        example_body = content[start.end(): start.end() + end.start()]
        after = content[start.end() + end.start():]
    else:
        example_body = content[start.end():]
        after = ""

    before = content[:start.start()]
    example_body = example_body.strip()

    # Split into input (variables) and output (code blocks / expected output)
    # Input: lines with - `{{...}}`: ... patterns
    # Output: everything else (code blocks, expected output shapes)
    input_lines = []
    output_lines = []
    current_section = []
    in_output = False

    for line in example_body.split('\n'):
        # New example block
        if re.match(r'^### ', line):
            if current_section:
                if in_output:
                    output_lines.extend(current_section)
                    output_lines.append('')
                else:
                    input_lines.extend(current_section)
                    input_lines.append('')
            current_section = [line]
            in_output = False
        elif re.match(r'^\*\*Input:\*\*', line):
            current_section.append(line)
            in_output = False
        elif re.match(r'^\*\*Expected Output', line):
            # flush input lines
            input_lines.extend(current_section)
            input_lines.append('')
            current_section = [line]
            in_output = True
        else:
            current_section.append(line)

    # flush last section
    if current_section:
        if in_output:
            output_lines.extend(current_section)
        else:
            input_lines.extend(current_section)

    skill_name = os.path.basename(os.path.dirname(skill_md_path))
    examples_dir = os.path.join(os.path.dirname(skill_md_path), "examples")
    os.makedirs(examples_dir, exist_ok=True)

    input_content = '\n'.join(input_lines).strip()
    output_content = '\n'.join(output_lines).strip()

    with open(os.path.join(examples_dir, "input.md"), 'w') as f:
        f.write(f"# Example Input: {skill_name}\n\n{input_content}\n")

    with open(os.path.join(examples_dir, "output.md"), 'w') as f:
        if output_content:
            f.write(f"# Example Output: {skill_name}\n\n{output_content}\n")
        else:
            f.write(f"# Example Output: {skill_name}\n\nSee input examples for expected output shapes.\n")

    # Rebuild SKILL.md: before + reference + after (next sections)
    new_content = before + REFERENCE + "\n" + after
    with open(skill_md_path, 'w') as f:
        f.write(new_content)

    return True


def main():
    processed = 0
    for root, dirs, files in os.walk(SKILLS_DIR):
        if "SKILL.md" in files:
            result = migrate(os.path.join(root, "SKILL.md"))
            if result:
                processed += 1
                print(f"✓ {root.replace(SKILLS_DIR + '/', '')}")
    print(f"\nTotal: {processed} migrated")


if __name__ == "__main__":
    main()
