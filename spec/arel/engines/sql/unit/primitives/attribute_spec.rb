require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Attribute do
    before do
      @relation = Table.new(:users)
      @attribute = @relation[:id]
    end
    
    describe '#column' do
      it "returns the corresponding column in the relation" do
        @attribute.column.should == @relation.column_for(@attribute)
      end
    end    
    
    describe '#to_sql' do
      describe 'for a simple attribute' do
        it "manufactures sql with an alias" do
          @attribute.to_sql.should be_like("`users`.`id`")
        end
      end
    end
  end
end