require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Project do
    before do
      @relation = Table.new(:users)
      @attribute = @relation[:id]
    end
  
    describe '#to_sql' do
      describe 'when given an attribute' do
        it "manufactures sql with a limited select clause" do
          Project.new(@relation, @attribute).to_sql.should be_like("
            SELECT `users`.`id`
            FROM `users`
          ")
        end
      end
      
      describe 'when given a relation' do
        before do
          @scalar_relation = Project.new(@relation, @relation[:name])
        end
        
        it "manufactures sql with scalar selects" do
          Project.new(@relation, @scalar_relation).to_sql.should be_like("
            SELECT (SELECT `users`.`name` FROM `users`) AS `users` FROM `users`
          ")
        end
      end
      
      describe 'when given a string' do
        it "passes the string through to the select clause" do
          Project.new(@relation, 'asdf').to_sql.should be_like("
            SELECT asdf FROM `users`
          ")
        end
      end
      
      describe 'when given an expression' do
        it 'manufactures sql with expressions' do
          @relation.project(@attribute.count).to_sql.should be_like("
            SELECT COUNT(`users`.`id`)
            FROM `users`
          ")
        end
      end
    end
  end
end