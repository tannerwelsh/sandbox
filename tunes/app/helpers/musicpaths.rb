helpers do
  def rel_path(path)
    path.sub(MUSIC_ROOT.to_s, '')
  end

  def basename(path)
    File.basename(path)
  end
end
