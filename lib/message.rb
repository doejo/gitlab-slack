class Message
  attr_reader :payload, :commits

  def initialize(payload)
    @payload = Hashr.new(payload)
    @commits = @payload.commits.map { |h| Hashr.new(h) }
  end

  def to_s
    return new_branch_message     if new_branch?
    return deleted_branch_message if deleted_branch?

    message = [
      payload.user_name,
      "pushed to branch",
      "<#{url("/commits/#{head_name}")}|#{head_name}>",
      "of",
      "<#{url}|#{head_name}>",
      "(<#{compare_url}|Compare changes>)"
    ].join(" ")

    lines = commits.map do |commit|
      "- #{commit.message.split("\n").first} (<#{commit_url(commit.id)}|#{commit.id[0,6]}>)"
    end

    message + "\n" + lines.join("\n")
  end

  private

  def new_branch?
    payload.before =~ /\A[0]{40}\z/
  end

  def deleted_branch?
    payload.after =~ /\A[0]{40}\z/
  end

  def head_name
    @head_name ||= payload.ref.split("/").last
  end

  def url(path = nil)
    "#{payload.repository.homepage}#{path}".strip
  end

  def new_branch_message
    [
      payload.user_name,
      "pushed new branch",
      "<#{url("/commits/#{head_name}")}|#{head_name}>",
      "to",
      "<#{url}|#{payload.repository.name}>"
    ].join(" ")
  end

  def deleted_branch_message
    [
      payload.user_name,
      "removed branch",
      head_name,
      "from",
      "<#{url}|#{payload.repository.name}>"
    ].join(" ")
  end

  def compare_url
    url("/compare/#{payload.before}...#{payload.after}")
  end

  def commit_url(sha)
    url("/commit/#{sha}")
  end
end