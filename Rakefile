require 'rake/clean'

CLEAN.include('{src,elpa-to-submit}/**/*.elc', '*.elc')

begin
  require 'git'

  # deactivate for logging
  @g = Git.open(Dir.pwd)

  # activate below for logging
  #require 'logger'
  #@g = Git.open(Dir.pwd, :log => Logger.new(STDOUT))

  CLOBBER.include(`git clean -Xdn | cut -d' ' -f3`.split)

  # git specific values can be change and use another repository
  GIT_OWNER = ENV['GIT_OWNER'] || "selman"
  GIT_NAME = "emacs-starter-kit"
  GIT_DEFAULT_BRANCH = "master"
  GIT_REMOTE_URLS = {
    :http => "http://github.com/#{GIT_OWNER}/#{GIT_NAME}.git",
    :git => "git://github.com/#{GIT_OWNER}/#{GIT_NAME}.git"
  }

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

  desc "creates/updates your #{BRANCH} branch"
  task :update do
    # add remote upstream if it is a fork and upstream not added as remote
    @g.add_remote(REMOTE, GIT_REMOTE_URLS[:git]) if @is_fork && @g.config['remote.upstream.url'].nil?

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
    require 'fileutils'
    require 'date'
    today = Date.today
    package_name = "esk-selman-#{today.year}-#{today.month}-#{today.day}"

    puts "creating package #{package_name}"
    @g.branch(GIT_DEFAULT_BRANCH).checkout
    esk_dir = Dir.pwd
    Dir.chdir("..")
    p = Git.clone(esk_dir, package_name)
    p.chdir { sh "git submodule update --init" }
    FileUtils.rm_rf Dir["#{package_name}/**/.git*"]
    sh "tar acf #{package_name}.tar.gz #{package_name} && rm -rf #{package_name}"
  end

rescue LoadError, ArgumentError
  puts "if this is a clone/fork \"sudo gem install git\" else dischard this message"
  task :default => ["rsense"]
end

desc "Replaces your \".emacs.d\" folder and updates if this is a clone/fork"
task :install do
  unless File.expand_path(File.dirname(__FILE__)) =~ %r/#{ENV['HOME']}\/\.emacs\.d/
    puts "preparing \".emacs.d\" directory"
    emacsd = File.join(ENV['HOME'], '.emacs.d')
    if File.exist?(emacsd)
      File.symlink?(emacsd) ? File.unlink(emacsd) : File.rename(emacsd, "#{emacsd}.bak")
    end
    symlink(Dir.pwd, emacsd)
  end

  Rake::Task[:update].invoke if Rake::Task.task_defined?(:update)
  Rake::Task[:rsense].invoke
end

desc "updates #{ENV['HOME']}/.rsense run this after every gem install to get new completions"
task :rsense do
  puts "creating .rsense file"
  ruby "src/rsense/etc/config.rb > #{ENV['HOME']}/.rsense"
end

desc "byte-compile lisp files"
task :bytecompile do
  lisp_paths = Dir['**/*.el'].map do |l|
    "-L #{File.dirname(l)} "
  end.uniq.join

  Dir['{src,elpa-to-submit}/**/*.el', '*.el'].each do |lisp|
    begin
      sh "emacs -Q #{lisp_paths} -batch -f batch-byte-compile #{lisp}"
    rescue
      nil
    end
  end
end
