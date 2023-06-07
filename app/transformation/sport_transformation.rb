class SportTransformation
  def self.sport(obj)
    {
      id: obj['id'],
      title: obj['desc'],
      hasInplayEvents: (obj['hasInplayEvents'] ? "Yes" : "N/A"),
      hasUpcomingEvents: (obj['hasUpcomingEvents'] ? "Yes" : "N/A"),
      comp_size: obj['comp'].size
    }
  end

  def self.sports(obj)
    obj.map(&method(:sport))
  end
end