require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Join do
    ActiveRecord::Base.configurations = {
      'arel' => {
        :adapter  => 'mysql',
        :username => 'root',
        :password => 'password',
        :encoding => 'utf8',
        :database => 'arel_test'
      }
    }
    ActiveRecord::Base.establish_connection 'arel'
    class BirdFeathers < ActiveRecord::Base; end
    BirdFeathers.connection.create_table(:bird_feathers, :force => true) do |t|
      t.integer :bird_id
      t.string :color
    end
    
    before do
      @relation1 = Array.new([
        [1, 'duck' ],
        [2, 'pigeon' ],
        [3, 'goose']
      ], [:id, :name])
      @relation2 = Table.new(:bird_feathers, Sql::Engine.new(BirdFeathers))
      @relation2.delete
      @relation2                                                                                  \
        .insert(@relation2[:id] => 1, @relation2[:bird_id] => 1, @relation2[:color] => 'yellow')  \
        .insert(@relation2[:id] => 2, @relation2[:bird_id] => 2, @relation2[:color] => 'gray')
    end

    describe 'when the in memory relation is on the left' do
      it 'joins across engines' do
        @relation1                                              \
          .join(@relation2)                                     \
            .on(@relation1[:id].eq(@relation2[:bird_id]))       \
          .project(@relation1[:name], @relation2[:color])       \
        .let do |relation|
          relation.call.should == [
            Row.new(relation, ['duck', 'yellow']),
            Row.new(relation, ['pigeon', 'gray'])
          ]
        end
      end
    end
    
    describe 'when the in memory relation is on the right' do
      it 'joins across engines' do
        @relation2                                              \
          .join(@relation1)                                     \
            .on(@relation1[:id].eq(@relation2[:bird_id]))       \
          .project(@relation1[:name], @relation2[:color])       \
        .let do |relation|
          relation.call.should == [
            Row.new(relation, ['duck', 'yellow']),
            Row.new(relation, ['pigeon', 'gray'])
          ]
        end
      end
    end
  end
end