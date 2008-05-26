module Arel
  class Predicate
  end

  class Binary < Predicate
    def eval(row)
      operand1.eval(row).send(operator, operand2.eval(row))
    end
  end

  class Equality < Binary
    def ==(other)
      Equality === other and
        ((operand1 == other.operand1 and operand2 == other.operand2) or
         (operand1 == other.operand2 and operand2 == other.operand1))
    end
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