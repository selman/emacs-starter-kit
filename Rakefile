require 'git'
require 'logger'

# git specific values can be change and use another repository
GIT_OWNER = "technomancy"
GIT_NAME = "emacs-starter-kit"
GIT_DEFAULT_BRANCH = "master"
GIT_REMOTE_URLS = {
  :http => "http://github.com/#{GIT_OWNER}/#{GIT_NAME}.git",
  :git => "git://github.com/#{GIT_OWNER}/#{GIT_NAME}.git"
}

# user specific values obeyed the github's forking guide
@g = Git.open(Dir.pwd, :log => Logger.new(STDOUT))
REMOTE_ORIGIN_URL = @g.config["remote.origin.url"]
BRANCH = ENV[:USER]
REMOTE = "upstream"
PUSH_REMOTE = "origin"
PUSH_BRANCH = "master"

@is_clone = false
GIT_REMOTE_URLS.values.each do |url|
  @is_clone = true if REMOTE_ORIGIN_URL == url
end

task :default => ["update"]

desc "installs my emacs for rails"
task :install do
  puts "preparing \".emacs.d\" directory"
  emacsd = File.join(ENV[:HOME], '.emacs.d')
  if File.exist?(emacsd)
    File.symlink?(emacsd) ? File.unlink(emacsd) : File.rename(emacsd, "#{emacsd}.bak")
  end
  require 'fileutils'
  FileUtils.ln_s(Dir.pwd, emacsd)
  if @is_clone
    # create/checkout branch created as username
    @g.branch(BRANCH).checkout if @is_clone
  else
    # add remote url if not added
    @g.add_remote(REMOTE, GIT_REMOTE_URLS[:git]) unless @g.config["remote.upstream.url"]
  end
end

desc "pull and merge if it is a clone or fetch and merge if it is a fork"
task :update do
  if @is_clone
    puts "pulling master branch and merging your #{BRANCH} branch"
    @g.branch(GIT_DEFAULT_BRANCH).checkout
    @g.pull
    @g.branch(BRANCH).checkout
    @g.merge(GIT_DEFAULT_BRANCH)
  else
    puts "fetching #{GIT_REMOTE_URLS[:git]} and merging your to fork"
    @g.remote(REMOTE).fetch
    @g.remote(REMOTE).merge(GIT_DEFAULT_BRANCH)
  end
end

desc "push your changes to your fork"
task :push do
  if @is_clone
    puts "your clone is readonly if you want to push your changes please fork"
  else
    puts "pushing your changes to your fork"
    @g.push(PUSH_REMOTE, PUSH_BRANCH)
  end
end
