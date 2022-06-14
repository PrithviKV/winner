require 'spec_helper'
require_relative '../lib/report'


RSpec.describe Report do
    describe '#result' do
      let (:start_year) { 2016 }
      let (:end_year) { 2019 }
      let (:awards_array) do
        [
          {"id"=>926, "category"=>"chemistry", "year"=>"2018", "month"=>"12", "day"=>"10", "winner_id"=>965},
          {"id"=>912, "category"=>"chemistry", "year"=>"2017", "month"=>"12", "day"=>"10", "winner_id"=>944},
          {"id"=>913, "category"=>"chemistry", "year"=>"2017", "month"=>"12", "day"=>"10", "winner_id"=>945},
          {"id"=>914, "category"=>"chemistry", "year"=>"2017", "month"=>"12", "day"=>"10", "winner_id"=>946},
          {"id"=>901, "category"=>"chemistry", "year"=>"2016", "month"=>"12", "day"=>"10", "winner_id"=>931},
          {"id"=>902, "category"=>"chemistry", "year"=>"2016", "month"=>"12", "day"=>"10", "winner_id"=>932}
        ]
      end
      let(:winners_array) do
        [
          {"id"=>965, "name"=>"Sir Gregory P. Winter", "birth_date"=>"1951-04-14", "death_date"=>nil},
          {"id"=>944, "name"=>"Jacques Dubochet", "birth_date"=>"1942-06-08", "death_date"=>nil},
          {"id"=>945, "name"=>"Joachim Frank", "birth_date"=>"1940-09-12", "death_date"=>nil},
          {"id"=>946, "name"=>"Richard Henderson", "birth_date"=>"1945-07-19", "death_date"=>nil},
          {"id"=>931, "name"=>"Jean-Pierre Sauvage", "birth_date"=>"1944-10-21", "death_date"=>nil},
          {"id"=>932, "name"=>"Sir J. Fraser Stoddart", "birth_date"=>"1942-05-24", "death_date"=>nil},
          {"id"=>933, "name"=>"Bernard L. Feringa", "birth_date"=>"1951-05-18", "death_date"=>nil}
        ]
      end

      let(:awards_array_2017) do
        [
          {"id"=>912, "category"=>"chemistry", "year"=>"2017", "month"=>"12", "day"=>"10", "winner_id"=>944},
          {"id"=>913, "category"=>"chemistry", "year"=>"2017", "month"=>"12", "day"=>"10", "winner_id"=>945},
          {"id"=>914, "category"=>"chemistry", "year"=>"2017", "month"=>"12", "day"=>"10", "winner_id"=>946},
        ]

      end

      let(:ids) do
        [ 944, 945, 946 ]
      end

      context 'no awards for a year 'do
        it 'returns nil' do
          expect(Report.get_awards_for_year(2019,awards_array)).to eq([])
        end
      end

      context 'awards for a given year' do
        it 'returns value ' do
          expect(Report.get_awards_for_year(2018,awards_array)).to eq([{"category"=>"chemistry", "day"=>"10", "id"=>926, "month"=>"12", "winner_id"=>965, "year"=>"2018"}])
        end
      end

      context 'get winners ids' do
        it 'returns ids' do
          expect(Report.get_winners_id(awards_array_2017)).to eq([944, 945, 946])
        end
      end

      context 'get names' do
        it 'returns names from the winners array' do
          expect(Report.get_names(ids,winners_array)).to eq(["Jacques Dubochet", "Joachim Frank", "Richard Henderson"])
        end
      end

      context 'get ages' do
        it 'returns age of the winner at the time of award' do
          year = 2017
          expect(Report.get_ages(winners_array, ids, year)).to eq([75, 77, 72])
        end
      end

      context 'sort names by last name' do
        it 'returns names in sorted order' do
          names = ["Richard Henderson","Sir J. Fraser Stoddart","Jacques Dubochet"]
          expect(Report.sort_names_by_last_name(names)).to eq(["Jacques Dubochet", "Richard Henderson", "Sir J. Fraser Stoddart"])
        end
      end
    end
end
