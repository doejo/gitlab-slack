class Payload < Hashr
  def initialize(hash = {})
    super(hash)
    
    commits.map! { |c| Hashr.new(c) }
  end

  def head
    ref.split("/").last
  end

  def new_branch?
    before =~ /\A[0]{40}\z/
  end

  def deleted_branch?
    after =~ /\A[0]{40}\z/
  end

  def url(path = nil)
    "#{repository.homepage}#{path}".strip
  end

  def compare_url
    url("/compare/#{before}...#{after}")
  end

  def commit_url(sha)
    url("/commit/#{sha}")
  end
end