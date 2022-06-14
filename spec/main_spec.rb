require 'spec_helper'
require_relative '../main'

RSpec.describe Main do
  describe '#run' do

    context 'invalid arguments' do
      it 'returns with a message' do
        expect do
          Main.run(['2020']).to output('Please excute this CLP with 3 arguments----> start_year, end_year, category').to_stdout
        end
      end
    end

  end

  describe '#valid category?' do

    context 'invalid category' do
      it 'returns false' do
        expect(Main.valid_category?('xxx')).to eq(false)
      end
    end

    context 'valid category' do
      it 'returns true' do
        expect(Main.valid_category?('chemistry')).to eq(true)
      end
    end
  end
end
