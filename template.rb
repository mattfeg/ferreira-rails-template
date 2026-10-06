# Ferreira Rails Template
# Usage: rails new myapp -d postgresql -c tailwind -m https://raw.githubusercontent.com/seu-usuario/ferreira-rails-template/main/template.rb
# Description: Template with Rspec, Shoulda Matchers, Faker, Devise, Pundit, Dotenv, Letter Opener, SimpleCov

# =============================================================================
# Setup Docker Compose with PostgreSQL
# =============================================================================

create_file 'docker-compose.yml' do
  <<~YAML
    services:
      postgres:
        image: postgres:16-alpine
        container_name: #{app_name}_postgres
        environment:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_INITDB_ARGS: "--encoding=UTF8 --locale=C"
        ports:
          - "5432:5432"
        volumes:
          - postgres_data:/var/lib/postgresql/data
        healthcheck:
          test: ["CMD-SHELL", "pg_isready -U postgres"]
          interval: 10s
          timeout: 5s
          retries: 5
        networks:
          - #{app_name}_network

    volumes:
      postgres_data:
        driver: local

    networks:
      #{app_name}_network:
        driver: bridge
  YAML
end

# =============================================================================
# Fix Master Key - Rails 8 creates an invalid key that breaks Devise/Solid gems
# =============================================================================

# Generate a valid 32-byte master key and encode it in Base64 (Rails format)
valid_master_key = SecureRandom.random_bytes(32)
valid_master_key_base64 = Base64.strict_encode64(valid_master_key).strip

# Rails created config/master.key but it's empty/invalid, so overwrite it
File.write('config/master.key', valid_master_key_base64)

# Also need to regenerate config/credentials.yml.enc with the new key
# Remove old encrypted credentials so Rails will create new ones
run 'rm -f config/credentials.yml.enc config/credentials.yml.enc.bak'

# =============================================================================
# Add Gems
# =============================================================================

gem_group :development, :test do
  gem 'rspec-rails', '~> 6.1'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'faker', '~> 3.2'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'dotenv-rails', '~> 2.8'
  gem 'simplecov', '~> 0.22', require: false
end

gem_group :development do
  gem 'letter_opener', '~> 1.10'
end

gem 'devise', '~> 4.9'
gem 'pundit', '~> 2.4'

# =============================================================================
# Environment Configuration
# =============================================================================

environment 'config.action_mailer.default_url_options = { host: "localhost:3000" }', env: 'development'
environment "config.action_mailer.delivery_method = :letter_opener", env: 'development'

# =============================================================================
# After Bundle Block
# =============================================================================

after_bundle do
  # =========================================================================
  # Clean up after Rails 8 auto-generation
  # =========================================================================
  
  # Remove .env file created by Kamal if it exists
  run 'rm -f .env' if File.exist?('.env')
  
  # =========================================================================
  # Setup RSpec with SimpleCov
  # =========================================================================
  
  generate 'rspec:install'
  
  # Configure SimpleCov for code coverage analysis
  inject_into_file 'spec/spec_helper.rb', before: "RSpec.configure do" do
    <<~RUBY
      require 'simplecov'
      SimpleCov.start 'rails' do
        add_filter '/spec/'
        add_filter '/config/'
      end

    RUBY
  end
  
  # Configure Shoulda Matchers for better RSpec assertions
  inject_into_file 'spec/rails_helper.rb', after: "require 'rspec/rails'\n" do
    <<~RUBY
      require 'shoulda/matchers'

      Shoulda::Matchers.configure do |config|
        config.integrate do |with|
          with.test_framework :rspec
          with.library :rails
        end
      end
    RUBY
  end
  
  # Configure Factory Bot for test data generation
  inject_into_file 'spec/rails_helper.rb', after: "RSpec.configure do |config|\n" do
    <<~RUBY
      config.include FactoryBot::Syntax::Methods

    RUBY
  end
  
  # =========================================================================
  # Create Factory Bot directory structure
  # =========================================================================

  run 'mkdir -p spec/factories'

  create_file 'spec/factories/.keep'

  # =========================================================================
  # Create User Factory
  # =========================================================================

  create_file 'spec/factories/users.rb' do
    <<~RUBY
      FactoryBot.define do
        factory :user do
          email { Faker::Internet.unique.email }
          password { 'Password123!' }
          password_confirmation { 'Password123!' }
        end
      end
    RUBY
  end
  
  # =========================================================================
  # Setup Devise for Authentication
  # =========================================================================

  generate 'devise:install'
  generate 'devise', 'User'

  # =========================================================================
  # Setup Pundit for Authorization
  # =========================================================================
  
  generate 'pundit:install'
  
  # =========================================================================
  # Setup Environment Variables
  # =========================================================================
  
  create_file '.env.local' do
    <<~ENV
      # Database
      DATABASE_URL=postgresql://postgres:postgres@localhost:5432/#{app_name}_development

      # Mail (Letter Opener)
      MAIL_HOST=localhost
      MAIL_PORT=3000

      # Add your environment variables here
    ENV
  end
  
  create_file '.env.example' do
    <<~ENV
      # Database
      DATABASE_URL=postgresql://postgres:postgres@localhost:5432/#{app_name}_development

      # Mail (Letter Opener)
      MAIL_HOST=localhost
      MAIL_PORT=3000

      # Add your environment variables here
    ENV
  end
  
  # =========================================================================
  # Update .gitignore
  # =========================================================================
  
  append_to_file '.gitignore' do
    <<~GIT
      # Environment variables
      .env.local
      .env*.local

      # Letter Opener
      tmp/letter_opener/

      # SimpleCov
      coverage/
      .resultset.json
    GIT
  end
  
  # =========================================================================
  # Initialize Git Repository
  # =========================================================================
  
  git :init
  git add: '.'
  git commit: %Q{ -m 'Initial commit: Rails app with Devise, Pundit, RSpec, Tailwind CSS' }
  
  # =========================================================================
  # Final Messages
  # =========================================================================
  
  say "\n" + "="*70
  say "✅ Template successfully applied!"
  say "="*70
  
  say "\n📋 Installed Gems:"
  say "  • rspec-rails - Testing framework"
  say "  • shoulda-matchers - RSpec matchers"
  say "  • faker - Generate fake data"
  say "  • factory_bot_rails - Test object factory"
  say "  • simplecov - Code coverage"
  say "  • devise - Authentication"
  say "  • pundit - Authorization"
  say "  • dotenv-rails - Environment variables"
  say "  • letter_opener - Email preview in development"
  say "  • tailwindcss - CSS framework"
  
  say "\n🚀 Next Steps:"
  say "  1. cd #{app_name}"
  say "  2. docker-compose up -d (start PostgreSQL first!)"
  say "  3. Wait for PostgreSQL to be ready (check with: docker-compose logs)"
  say "  4. rails db:create db:migrate (create and migrate database)"
  say "  5. Review .env.local file if needed"
  say "  6. bin/dev (run Rails + Tailwind)"
  say "  7. Visit http://localhost:3000"
  say "  8. Emails automatically open in /letter_opener"
  say "  9. User model with Devise authentication is ready to use!"
  
  say "\n📝 Configurations:"
  say "  • Docker Compose with PostgreSQL 16 (docker-compose.yml)"
  say "  • Devise installed with User model"
  say "  • User factory created for testing"
  say "  • Pundit installed with ApplicationPolicy template"
  say "  • RSpec configured with Shoulda Matchers"
  say "  • SimpleCov for test coverage (coverage/)"
  say "  • PostgreSQL as database"
  say "  • Tailwind CSS ready to use"
  say "  • .env.local and .env.example configured"
  
  say "\n🐳 Docker Commands:"
  say "  docker-compose up -d    # Start PostgreSQL"
  say "  docker-compose down     # Stop PostgreSQL"
  say "  docker-compose logs     # View logs"
  
  say "\n" + "="*70 + "\n"
end
