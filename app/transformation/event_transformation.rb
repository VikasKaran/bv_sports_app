class EventTransformation
  def self.event(obj)
    {
      id: obj['id'],
      title: obj['desc'],
      scrA: obj['scoreboard']['scrA'],
      scrB: obj['scoreboard']['scrB'],
      inPlay: (obj['scoreboard']['inPlay'] ? "Yes" : "No")    
    }
  end

  def self.events(obj)
    obj.map(&method(:sport))
  end
end