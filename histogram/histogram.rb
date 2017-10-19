ROOT_DIR = File.expand_path('..', __FILE__)

def commits
  system("git --no-pager log")
end

if __FILE__ == $PROGRAM_NAME
  p commits
end
