module Arel
  class Binary < Predicate
    def eval(row)
      operand1.eval(row).send(operator, operand2.eval(row))
    end
  end

  class Equality < Binary
  end

  class GreaterThanOrEqualTo < Binary
  end

  class GreaterThan < Binary
  end

  class LessThanOrEqualTo < Binary
  end

  class LessThan < Binary
    def operator; :< end
  end

  class Match < Binary
  end
  
  class In < Binary
  end
end