class Message
  attr_reader :payload

  def initialize(payload)
    @payload = Hashr.new(payload)
  end

  def to_s
    if new_branch?
      return new_branch_message
    end

    if deleted_branch?
      return deleted_branch_message
    end
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
end