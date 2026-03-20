# .zshrc Configuration

```bash
# Setup nano as default editor

export EDITOR=nano

# Setup default node env to development

export NODE_ENV=development

# Setup default rails env to development

export RAILS_ENV=development

# Open current folder with Finder

alias f="open ."

# Open current folder with VSCode

alias c="code ."

# Go to desktop quickly

alias cdd="cd /Users/galante/Desktop"

# Go to Workspace quickly

alias cdw="cd /Users/galante/Workspace"

# Go to Wordpress themes folder quickly on Local project

alias wp-local-themes="cd app/public/wp-content/themes"

# Go to Wordpress plugins folder quickly on Local project

alias wp-local-plugins="cd app/public/wp-content/plugins"

# Start redis server quickly without persistence

alias redis-start="redis-server --daemonize yes --save \"\""
alias redis-stop="redis-cli shutdown"
alias redis-status="redis-cli ping"
alias redis-clear="redis-cli flushall"

# Do a rapid commit and push to Github

gcom () {
    git add -A
    git commit -m "$1"
    git pull
    git push
    git fetch
}

# Clean up github branches

gclean () {
    git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# Clean up Workspace folder

alias wsizes="cd /Users/galante/Workspace && find . -maxdepth 1 -mindepth 1 -type d -exec du -hs {} \;"

wclean () {
  cd /Users/galante/Workspace
  # Remove all .DS_Store files
  find . -name '*.DS_Store' -type f -delete
  # Remove all node_modules folders
  find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
  # Remove all .log files
  find . -name '*.log' -type f -delete
}

# Run rails tasks quickly

alias rails-db-dev="rm -rf db/schema.rb && rails db:drop RAILS_ENV=development && rails db:create RAILS_ENV=development && rails db:migrate RAILS_ENV=development && rails db:seed RAILS_ENV=development"

alias rails-db-test="rm -rf db/schema.rb && rails db:drop RAILS_ENV=test && rails db:create RAILS_ENV=test && rails db:migrate RAILS_ENV=test && rails db:seed RAILS_ENV=test"

# Compile React native project for Android

alias rn-compile-aab="cd android && ./gradlew clean && ./gradlew bundleRelease && cd app/build/outputs/bundle/release && open ./"

alias rn-compile-apk="cd android && ./gradlew clean && ./gradlew assembleRelease && cd app/build/outputs/apk/release && open ./"

alias rn-compile-apk-dev="cd android && ./gradlew assembleDebug && cd app/build/outputs/apk/debug && open ./"

# SSH Management

ssh-list() {
    echo "Listing all aliases:"
    echo ""
    alias | grep "ssh-"
}

# example
alias ssh-myserver="ssh user@0.0.0.0"

##################

# Free for envs for services