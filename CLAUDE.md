# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (requires Neovim 0.11+) built on lazy.nvim plugin manager. The configuration follows a modular structure where each plugin has its own file in `lua/plugins/`.

## Architecture

### Bootstrap and Loading Sequence

The entry point is `init.lua`, which sets up the leader key (Space) and loads modules in this order:
1. `options.lua` - Neovim settings
2. `keymaps.lua` - Key bindings
3. `autocmds.lua` - Auto commands
4. `lazy-bootstrap.lua` - Installs lazy.nvim if not present
5. `lazy-plugins.lua` - Initializes lazy.nvim and imports plugins from `lua/plugins/`

### Plugin Structure

Each plugin is defined in `lua/plugins/*.lua` and returns a lazy.nvim plugin specification table. The plugin manager automatically loads all modules from the `plugins` directory via the `{ import = 'plugins' }` directive in `lazy-plugins.lua`.

### Key Plugin Components

- **LSP**: `lspconfig.lua` handles all LSP configuration, including Mason for tool installation, capabilities from blink.cmp, and LSP keybindings via the LspAttach autocmd
- **Completion**: `blink-cmp.lua` provides autocompletion with LuaSnip for snippets
- **Telescope**: `telescope.lua` for fuzzy finding files, grepping, LSP symbols, etc.
- **Treesitter**: `treesitter.lua` for syntax highlighting and code understanding
- **Formatting**: `conform.lua` handles code formatting (stylua for Lua, ruff for Python)
- **Mini.nvim**: `mini.lua` provides many small utilities (surround, comment, bufremove, statusline, etc.)

### Plugin Source Code and Documentation Access

The actual plugin source code is installed in `/home/robertfw/.local/share/nvim/lazy/`. Claude Code can access these files directly when you need to reference plugin documentation, implementation details, check API usage, or debug plugin behavior.

Neovim's built-in documentation (all `:help` files) is located at `/snap/nvim/current/usr/share/nvim/runtime/doc/`. Reference these when you need to check Neovim API details, configuration options, or built-in functionality. 

## Custom Keybinding Patterns

### Helper Functions in keymaps.lua

The file defines `norm()` and `leader()` helper functions to simplify keymap definitions:
- `norm(key, action, desc)` - Normal mode binding
- `leader(key, action, desc)` - Leader key binding

### Leader Key Structure

All `<leader>` keymaps are organized by prefix:
- `<leader>f*` - File operations (fs=save, ff=find, fh=find hidden)
- `<leader>b*` - Buffer operations (bd=delete, <tab>=last buffer)
- `<leader>w*` - Window operations (ws=split, wv=vsplit, wH/J/K/L=move window)
- `<leader>s*` - Search operations (sg=grep, sw=word, sd=diagnostics) [defined in telescope.lua]
- `<leader>t*` - Toggle operations (th=inlay hints) [defined in lspconfig.lua]
- `<leader>u*` - Utilities (ux=execute+copy, uu=insert UUID)

### Insert Mode Shortcuts

- `jj` - Exit insert mode
- `jk` - Exit insert mode and save
- `hh` - Accept completion (blink.cmp)

### LSP Keybindings

LSP keybindings are set up in the LspAttach autocmd in `lspconfig.lua`:
- `gr*` prefix for LSP "goto" operations (grn=rename, gra=code action, grr=references, grd=definition, gri=implementation, grt=type definition, grD=declaration)
- `<leader>.` - Document symbols
- `gW` - Workspace symbols

## Configuration Details

### Session Management

The config uses auto-session with specific sessionoptions set in `options.lua:81` to persist window layouts, buffers, and terminal states.

### LSP Servers

Currently configured LSP servers (in `lspconfig.lua:155-173`):
- `ruff` - Python linting/formatting
- `ty` - Python type checking (with many rules currently ignored, see commented pyproject.toml snippet at end of lspconfig.lua)
- `lua_ls` - Lua language server with lazydev.nvim for Neovim API completion

### Diagnostic Configuration

Diagnostics are configured in `lspconfig.lua:113-138` with:
- Severity sorting enabled
- Only ERROR severity shown with underlines
- Virtual text shows full messages
- Nerd Font icons for severity levels

## Modifying This Configuration

### Adding a New Plugin

Create a new file `lua/plugins/plugin-name.lua` that returns a lazy.nvim plugin spec table. It will be automatically loaded.

### Adding LSP Servers

Add the server to the `servers` table in `lspconfig.lua:155` and it will be automatically installed via mason-tool-installer and configured.

### Adding Formatters

Add formatters to `conform.lua:18` in the `formatters_by_ft` table. The formatter can be triggered with `<leader>f`.

### Custom Keybindings

Add custom keybindings to `keymaps.lua` using the `norm()` or `leader()` helper functions, or add them directly with `vim.keymap.set()`.
