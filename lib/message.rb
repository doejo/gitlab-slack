class Message
  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def to_s
    return new_branch_message     if payload.new_branch?
    return deleted_branch_message if payload.deleted_branch?

    (push_message + "\n" + commit_lines).strip
  end

  private

  def push_message
    [
      payload.user_name,
      "pushed to branch",
      link_to(payload.head, "/commits/#{payload.head}"),
      "of",
      link_to(payload.repository.name),
      "(#{ link_to_compare })"
    ].join(" ")
  end

  def new_branch_message
    [
      payload.user_name,
      "pushed new branch",
      link_to(payload.head, "/commits/#{payload.head}"),
      "to",
      link_to(payload.repository.name)
    ].join(" ")
  end

  def deleted_branch_message
    [
      payload.user_name,
      "removed branch",
      payload.head,
      "from",
      link_to(payload.repository.name)
    ].join(" ")
  end

  def commit_lines
    lines = payload.commits.map do |commit|
      "- #{commit.message.split("\n").first} (#{ link_to_commit(commit.id) })"
    end

    lines.empty? ? "" : lines.join("\n")
  end

  def link_to(title, path = nil)
    "<#{ payload.url(path) }|#{ title }>"
  end

  def link_to_compare
    "<#{ payload.compare_url }|Compare changes>"
  end

  def link_to_commit(id)
    "<#{ payload.commit_url(id) }|#{ id[0,6] }>"
  end
end