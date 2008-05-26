module Arel
  class Value
    attributes :value, :relation
    deriving :initialize, :==
    
    def bind(relation)
      Value.new(value, relation)
    end
  end
end