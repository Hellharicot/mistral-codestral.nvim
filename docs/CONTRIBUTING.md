# Contributing to mistral-codestral.nvim

Thank you for considering contributing to mistral-codestral.nvim! This guide will help you understand the development workflow and release process.

## Development Workflow

### Prerequisites

- Neovim v0.10.0 or later
- Git
- Basic understanding of Lua and Neovim plugin development

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/jrollin/mistral-codestral.nvim.git
cd mistral-codestral.nvim
```

2. Run tests locally:
```bash
bash scripts/ci_test.sh
```

3. Check code formatting:
```bash
# Install StyLua
brew install stylua  # macOS
# or download from https://github.com/JohnnyMorganz/StyLua/releases

# Check formatting
stylua --check lua/ tests/

# Auto-format
stylua lua/ tests/
```

4. Run linting:
```bash
# Install Luacheck
luarocks install luacheck

# Run linter
luacheck lua/ --globals vim
```

## Commit Message Format

This project uses automated releases based on [Conventional Commits](https://www.conventionalcommits.org/).

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

- `feat`: New feature (bumps **minor** version: v0.1.0 → v0.2.0)
- `fix`: Bug fix (bumps **patch** version: v0.1.0 → v0.1.1)
- `docs`: Documentation only (no version bump)
- `refactor`: Code refactoring (no version bump)
- `test`: Adding tests (no version bump)
- `chore`: Maintenance tasks (no version bump)
- `perf`: Performance improvements (bumps patch version)
- `BREAKING CHANGE`: Breaking change (bumps **major** version: v0.1.0 → v1.0.0)

### Scopes (Optional)

Common scopes for this project:
- `cmp`: nvim-cmp integration
- `blink`: blink.cmp integration
- `virtual-text`: Virtual text functionality
- `auth`: Authentication/API key handling
- `lsp`: LSP integration
- `config`: Configuration system

### Examples

**Feature (bumps minor version):**
```bash
git commit -m "feat: add multi-line virtual text support"
git commit -m "feat(cmp): implement item ranking algorithm"
```

**Bug fix (bumps patch version):**
```bash
git commit -m "fix: resolve API timeout handling"
git commit -m "fix(auth): correct key validation edge case"
```

**Breaking change (bumps major version):**
```bash
git commit -m "feat!: redesign configuration API

BREAKING CHANGE: Configuration structure has changed.
Old: setup({ api_key = \"...\" })
New: setup({ auth = { api_key = \"...\" } })"
```

**No version bump:**
```bash
git commit -m "docs: update installation instructions"
git commit -m "test: add integration tests for virtual text"
git commit -m "chore: update GitHub Actions to v4"
```

## Release Process

### Automated Release Workflow

1. **Commit with conventional format** to main branch
2. **GitHub Actions CI** runs tests and linting
3. **Release-Please bot** analyzes commits since last release
4. **Release PR is created** automatically with:
   - Updated CHANGELOG.md
   - Updated version in lua/mistral-codestral/init.lua
   - Calculated semantic version
5. **Maintainer reviews** and merges the release PR
6. **Automated release** is published:
   - Git tag created (e.g., v0.1.0)
   - GitHub release with notes
   - CHANGELOG.md updated in repository

### Version Pinning for Users

Once a release is published, users can install specific versions:

```lua
-- Pin to specific version
{ 'jrollin/mistral-codestral.nvim', tag = 'v0.1.0' }

-- Pin to minor version range
{ 'jrollin/mistral-codestral.nvim', tag = 'v0.*' }

-- Always use latest (not recommended for production)
{ 'jrollin/mistral-codestral.nvim' }
```

## Versioning

This project follows [Semantic Versioning](https://semver.org/):

- **Major (X.0.0)**: Breaking changes (incompatible API changes)
- **Minor (0.X.0)**: New features (backward compatible)
- **Patch (0.0.X)**: Bug fixes (backward compatible)

### Pre-1.0 Versioning

Currently, the plugin is in **pre-stable** phase (v0.x.x), which means:
- API may change between minor versions
- Breaking changes bump the minor version (not major)
- Once API is stable, we'll release v1.0.0

## Code Quality Standards

### Testing

All changes should include tests when applicable:

```bash
# Run test suite
bash scripts/ci_test.sh

# Test specific file
nvim --headless --noplugin -u NONE \
  -c "set runtimepath+=." \
  -c "luafile tests/plugin_test.lua"
```

### Linting

Code must pass linting checks:

```bash
# Format check (will fail CI if not formatted)
stylua --check lua/ tests/

# Static analysis
luacheck lua/ --globals vim
```

### Documentation

- Update relevant documentation in `/docs` for feature changes
- Follow DRY principle (link instead of duplicating)
- Use clear, concise language
- Include code examples where helpful

## Testing Before Submitting

Before pushing your changes:

```bash
# 1. Check commit format
git log -1 --pretty=format:"%s"

# 2. Run tests
bash scripts/ci_test.sh

# 3. Check formatting
stylua --check lua/ tests/

# 4. Run linter
luacheck lua/ --globals vim
```

Or use the comprehensive test script:

```bash
bash scripts/test_release.sh
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/my-feature`
3. Make your changes following conventional commits
4. Ensure tests pass and code is formatted
5. Push to your fork: `git push origin feat/my-feature`
6. Create a Pull Request to `main` branch
7. Wait for CI checks to pass
8. Address any review feedback

### PR Guidelines

- Keep PRs focused on a single feature/fix
- Write clear PR descriptions
- Reference related issues if applicable
- Ensure CI passes before requesting review
- Update documentation if needed

## Need Help?

- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
- Review [ARCHITECTURE.md](ARCHITECTURE.md) to understand the codebase
- Open an issue for questions or discussion
- Tag maintainers for urgent matters

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
