# Example Output: design-mcp-quickstart

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**Step 1 — Prerequisites**

| Prerequisite | Min Version / Plan | Verify | Get It |
|---|---|---|---|
| Node.js | v18 or later | Run: node --version | https://nodejs.org |
| Figma account | Free plan or above | Log in at figma.com | https://figma.com/signup |
| Figma personal access token | Any | Figma → Settings → Security → Personal access tokens | Generate in Figma settings |
| Claude Desktop | Latest | Open Claude Desktop, check About | https://claude.ai/download |

**Step 2 — Installation**

```bash
npm install -g figma-mcp
figma-mcp --version
```

**Step 3 — Configuration**

Open `~/Library/Application Support/Claude/claude_desktop_config.json` and add:

```json
{
  "mcpServers": {
    "figma": {
      "command": "figma-mcp",
      "args": [],
      "env": {
        "FIGMA_ACCESS_TOKEN": "YOUR_FIGMA_API_TOKEN"
      }
    }
  }
}
```

Restart Claude Desktop after saving.

**Step 4 — Verification**

Prompt: `"Use the Figma MCP tool to get my Figma account information."`

Expected: Claude returns your Figma user name, email, and account ID.

**Step 5 — First Use Example**

Prompt: `"Use Figma MCP to create a new Figma file called 'App Wireframes' and add a frame sized 375×812 named 'Home Screen'."`

Expected: Claude creates a new Figma file and returns its URL.
