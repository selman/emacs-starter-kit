require 'git'
require 'fileutils'

# git specific values can be change and use another repository
GIT_OWNER = ENV['GIT_OWNER'] || "selman"
GIT_NAME = "emacs-starter-kit"
GIT_DEFAULT_BRANCH = "master"
GIT_REMOTE_URLS = {
  :http => "http://github.com/#{GIT_OWNER}/#{GIT_NAME}.git",
  :git => "git://github.com/#{GIT_OWNER}/#{GIT_NAME}.git"
}

# deactivate for logging
@g = Git.open(Dir.pwd)

# activate below for logging
#require 'logger'
#@g = Git.open(Dir.pwd, :log => Logger.new(STDOUT))

# user specific values obeyed the github's forking guide
# if you don't want to use your machine user change below
BRANCH = ENV['USER']
REMOTE = "upstream"
REMOTE_ORIGIN_URL = @g.config["remote.origin.url"]

@is_fork = true
GIT_REMOTE_URLS.values.each do |url|
  @is_fork = false if REMOTE_ORIGIN_URL == url
end

task :default => ["update"]

desc "installs #{GIT_NAME} and creates/updates your #{BRANCH} branch"
task :install do
  puts "preparing \".emacs.d\" directory"
  emacsd = File.join(ENV['HOME'], '.emacs.d')
  if File.exist?(emacsd)
    File.symlink?(emacsd) ? FileUtils.rm(emacsd) : File.rename(emacsd, "#{emacsd}.bak")
  end
  symlink(Dir.pwd, emacsd)

  # create/checkout branch created as username
  @g.branch(BRANCH).checkout

  # add remote upstream if it is a fork and upstream not added as remote
  @g.add_remote(REMOTE, GIT_REMOTE_URLS[:git]) if @is_fork && @g.config['remote.upstream.url'].nil?

  # updates your submodules and other jobs
  Rake::Task[:submodules].invoke
end

desc "pull and merge if it is a clone or fetch and merge if it is a fork"
task :update do
  # checkout branch to default branch and pull
  # if it is a fork pulls any code comitted before
  # if it is a clone it updates your default branch
  puts "#{GIT_DEFAULT_BRANCH} pulling"
  @g.branch(GIT_DEFAULT_BRANCH).checkout
  @g.pull

  # fetch remote and merge it to your default branch
  if @is_fork
    puts "fetching #{GIT_REMOTE_URLS[:git]} and merging to your #{GIT_DEFAULT_BRANCH} branch"
    @g.remote(REMOTE).fetch
    @g.remote(REMOTE).merge(GIT_DEFAULT_BRANCH)
  end

  # return your branch and merge your default branch
  puts "#{GIT_DEFAULT_BRANCH} branch merging to your #{BRANCH} branch"
  @g.branch(BRANCH).checkout
  @g.merge(GIT_DEFAULT_BRANCH)

  # updates your submodules and other jobs
  Rake::Task[:submodules].invoke
end

desc "updates submodules"
task :submodules do
  # no submodule function in 'git' gem
  puts "updating your submodules"
  sh "git submodule update --init"
  Rake::Task[:rsense].invoke
  # add here submodule specific install options
  # example;
  # sh 'cd src/org && make'
end

desc "updates #{ENV['HOME']}/.rsense run this after every gem install to get new completions"
task :rsense do
  puts "creating .rsense file"
  ruby "src/rsense/etc/config.rb > #{ENV['HOME']}/.rsense"
end

if @is_fork
  desc "merges your #{BRANCH} branch to #{GIT_DEFAULT_BRANCH} branch"
  task :merge do
    Rake::Task[:update].invoke
    puts "merging your changes at #{BRANCH} branch to #{GIT_DEFAULT_BRANCH} branch"
    @g.branch(GIT_DEFAULT_BRANCH).checkout
    @g.merge(BRANCH)
  end

  desc "pushs your changes to your fork"
  task :push do
    puts "pushing your changes to your fork"
    # git push origin master
    @g.push()
  end
end

desc "create static package"
task :package do
  require 'date'
  today = Date.today
  packagename = "esk-selman-#{today.year}-#{today.month}-#{today.day}"
  emacsd = ".emacs.d"

  puts "creating package #{packagename}"
  @g.branch(GIT_DEFAULT_BRANCH).checkout
  projectdir = Dir.pwd
  Dir.chdir("..")
  p = Git.clone(projectdir, emacsd)
  p.chdir { sh "git submodule update --init" }
  FileUtils.rm_rf Dir["#{emacsd}/**/{.git*,Rakefile}"]
  sh "tar acf #{packagename}.tar.gz #{emacsd} && rm -rf #{emacsd}"
end
