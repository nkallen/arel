module Arel
  class Insert < Compound
    def to_sql(formatter = nil)
      [
        "INSERT",
        "INTO #{table_sql}",
        "(#{record.keys.collect(&:to_sql).join(', ')})",
        "VALUES (#{record.collect { |key, value| key.format(value) }.join(', ')})"
      ].join("\n")
    end
  end
end