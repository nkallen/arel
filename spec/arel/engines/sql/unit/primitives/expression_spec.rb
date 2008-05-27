require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Expression do
    before do
      @relation = Table.new(:users)
      @attribute = @relation[:id]
    end
    
    describe '#to_sql' do
      it "manufactures sql with the expression and alias" do
        Count.new(@attribute, :alias).to_sql.should == "COUNT(`users`.`id`) AS `alias`"
      end
    end
  end
end