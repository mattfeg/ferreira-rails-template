# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-06

### Added
- Initial release of Ferreira Rails Template
- RSpec with Shoulda Matchers for testing
- Factory Bot Rails for test object creation
- SimpleCov for code coverage analysis
- Faker gem for test data generation
- Devise for user authentication
- Pundit for authorization/policies
- Docker Compose with PostgreSQL 16 Alpine
- Tailwind CSS support
- Letter Opener for email preview in development
- Dotenv-rails for environment variable management
- Automatic Git initialization with initial commit
- Comprehensive README with usage instructions
- Environment files (.env.local, .env.example)
- Kamal deployment configuration support

### Technical Details
- Rails 8.1+
- Ruby 3.4+
- PostgreSQL 16 (via Docker)
- Auto-generates valid master key to prevent encryption errors
- Factory Bot ready with spec/factories directory

---

## Future Versions

### Planned for v1.1.0
- [ ] GitHub Actions CI/CD workflow example
- [ ] Database seeding examples
- [ ] Test factory setup (Factory Bot)
- [ ] API documentation support
- [ ] Development gems like byebug/pry configuration

### Under consideration
- [ ] Docker image for Rails app itself
- [ ] Sidekiq for background jobs
- [ ] Redis configuration
- [ ] Elasticsearch integration example
- [ ] Sentry for error tracking
- [ ] S3/Cloud storage setup guide

---

**Note**: This is a living document. Check back for updates and improvements!
