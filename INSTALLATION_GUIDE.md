# Installation Guide - Publishing to GitHub

This guide explains how to set up and publish the `ferreira-rails-template` to your GitHub account.

## Prerequisites

- GitHub account
- Git installed locally
- Basic familiarity with GitHub

## Step-by-Step Setup

### 1. GitHub Repository Created ✓

Your repository is now live at:
```
https://github.com/your-nick/ferreira-rails-template
```

### 2. Files Already Pushed ✓

All template files are now on GitHub:
```
https://github.com/mattfeg/ferreira-rails-template
```

You should see:
- ✅ All files (template.rb, README.md, CHANGELOG.md, etc.)
- ✅ README displayed on the main page
- ✅ Green "Code" button ready to clone

## Using the Template

### From GitHub URL

```bash
rails new myapp \
  -d postgresql \
  -c tailwind \
  -m https://raw.githubusercontent.com/mattfeg/ferreira-rails-template/main/template.rb
```

Or from a local path:

```bash
rails new myapp -d postgresql -c tailwind -m ~/path/to/ferreira-rails-template/template.rb
```

## Making Updates

When you make changes to the template:

```bash
# Make your changes to template.rb or other files

# Update CHANGELOG.md with the new version

# Commit
git add .
git commit -m "Update: Description of changes"

# Push to GitHub
git push origin main
```

Users will automatically get the latest version from GitHub.

## Adding Release Tags (Optional but Recommended)

Tagging versions makes it easier to track changes:

```bash
# Tag a version
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push tags to GitHub
git push origin --tags
```

Then go to GitHub → Releases and it will show your tagged versions.

## GitHub Badges (Optional)

Add badges to your README.md to make it look professional:

```markdown
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Rails](https://img.shields.io/badge/Rails-8.1-cc0000.svg)](https://rubyonrails.org)
[![Ruby](https://img.shields.io/badge/Ruby-3.4+-cc342d.svg)](https://www.ruby-lang.org)
```

## Sharing Your Template

### Share the Raw URL

For others to use your template:

```
https://raw.githubusercontent.com/your-nick/ferreira-rails-template/main/template.rb
```

### Share on Social Media

"Just created a Rails 8 template with all the essentials! 🚀
- RSpec + Shoulda Matchers
- Devise + Pundit  
- Docker + PostgreSQL
- Tailwind CSS

Check it out: https://github.com/your-nick/ferreira-rails-template"

### Add to Ruby.dev or Similar Sites

Consider adding your template to:
- [Awesome Rails](https://github.com/dpaluy/awesome-rails)
- [Awesome Ruby Templates](https://github.com/topics/rails-template)

Just create an issue on those repositories with your template link.

## Troubleshooting

### "Permission denied" when pushing

```bash
# Check your SSH key setup
ssh -T git@github.com

# If SSH doesn't work, use HTTPS
git remote set-url origin https://github.com/your-nick/ferreira-rails-template.git
```

### Raw GitHub URL not working

The URL must be:
```
https://raw.githubusercontent.com/your-nick/ferreira-rails-template/main/template.rb
```

Not:
```
https://github.com/your-nick/ferreira-rails-template/raw/main/template.rb
```

### Template has outdated info

Update the files directly on GitHub:
1. Open the file in GitHub's web editor
2. Make changes
3. Commit directly to main

Or locally:
```bash
git pull origin main
# Make changes
git push origin main
```

## Security

- Keep sensitive information OUT of the template
- Never commit API keys or passwords
- Use `.env.example` for template variables only
- Review contributions carefully before merging

## Stats & Monitoring

To see who's using your template:

1. Go to Insights → Traffic
2. See clones, visitors, referrers
3. Watch GitHub notifications for issues/PRs

## Support

If users have questions, they can:
- Open an issue
- Check the README
- See CONTRIBUTING.md for contribution guidelines
- Contact you via GitHub

---

**That's it! Your template is now ready for the world to use! 🎉**
