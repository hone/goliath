require "pathname"

module PathHelper
  def fixtures_path(file)
    Pathname.new(File.join(File.dirname(__FILE__), "../fixtures/#{file}"))
  end
end
