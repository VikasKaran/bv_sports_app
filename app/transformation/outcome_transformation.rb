class OutcomeTransformation
  def self.outcome(obj)
    {
      id: obj['oid'],
      title: obj['d'],
      pr: obj['pr'],
      keyDimension: obj['keyDimension']
    }
  end

  def self.outcomes(obj)
    obj.map(&method(:outcome))
  end
end