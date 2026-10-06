# Contributing to Ferreira Rails Template

Thank you for your interest in contributing! We welcome all types of contributions.

## Ways to Contribute

### Report Bugs

If you find a bug:

1. **Check if it's already reported** in [Issues](https://github.com/mattfeg/ferreira-rails-template/issues)
2. **Open a new issue** with:
   - Clear title describing the problem
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Your environment (Ruby version, Rails version, etc.)

### Suggest Improvements

Have an idea to make the template better?

1. Open an issue with the label `enhancement`
2. Describe the improvement and why it would be useful
3. Provide examples or mockups if helpful

### Fix Bugs or Add Features

Want to code? Great!

#### Setup

```bash
# Clone the repository
git clone https://github.com/mattfeg/ferreira-rails-template.git
cd ferreira-rails-template

# Create a test app to verify changes
rails new test_app -d postgresql -c tailwind -m ./template.rb
cd test_app
docker-compose up -d
rails db:create db:migrate
bin/dev
```

#### Process

1. **Create a branch** from `main`
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/bug-description
   ```

2. **Make your changes**
   - Keep commits atomic and well-described
   - Follow Rails conventions
   - Test the template by creating a fresh app

3. **Update documentation**
   - Update README.md if needed
   - Add entry to CHANGELOG.md under "Unreleased"
   - Update version numbers if appropriate

4. **Commit your changes**
   ```bash
   git commit -m "Add: Description of your change"
   ```

5. **Push and create a Pull Request**
   ```bash
   git push origin feature/your-feature-name
   ```

## Code Style

- Follow Rails conventions
- Use Ruby 3.4+ syntax
- Keep the template focused and lean
- Add comments for non-obvious changes

## Testing Your Changes

Always test the template works correctly:

```bash
# Create a fresh test app
rails new test_app -d postgresql -c tailwind -m ./template.rb

# Follow the quick start steps
cd test_app
docker-compose up -d
rails db:create db:migrate
bin/dev

# Verify:
# 1. App starts successfully
# 2. Devise routes work
# 3. RSpec is configured
# 4. Tests run: rspec
# 5. Email opens in browser
```

## Pull Request Guidelines

- Use a descriptive title
- Link related issues: "Closes #123"
- Describe what changed and why
- Include before/after if applicable
- Test your changes thoroughly

Example PR description:

```markdown
## Description

Add SimpleCov configuration for test coverage tracking.

## Related Issues

Closes #45

## Changes

- Configure SimpleCov in spec_helper.rb
- Add coverage/ to .gitignore
- Document coverage in README

## Testing

Tested with:
- Rails 8.1.4
- Ruby 3.4.6
- PostgreSQL 16

Test app created and verified all features work.
```

## Naming Conventions

### Branches
- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation updates
- `chore/description` - Maintenance tasks

### Commits
- `Add: Description` - New feature
- `Fix: Description` - Bug fix
- `Update: Description` - Improvement
- `Remove: Description` - Removal
- `Docs: Description` - Documentation

## Questions?

- Check the README.md
- Search existing issues
- Open a discussion issue
- Contact the maintainer

## Code of Conduct

Be respectful, inclusive, and professional. We're all here to make this template better!

---

**Thank you for contributing! 🎉**
