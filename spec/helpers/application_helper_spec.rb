require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#game_detail_page?' do
    subject { helper.game_detail_page? }

    before do
      allow(helper).to receive(:current_page?).with(root_path).and_return(false)
      allow(helper).to receive(:current_page?).with(rules_path).and_return(false)
      allow(helper).to receive(:current_page?).with(terms_path).and_return(false)
      allow(helper).to receive(:current_page?).with(credits_path).and_return(false)
      allow(helper).to receive(:current_page?).with(privacy_policy_path).and_return(false)
      allow(helper).to receive(:current_page?).with(games_path).and_return(false)
    end

    context '正常系' do
      it 'game_detail_pageのとき, trueが返ること' do
        expect(subject).to be_truthy
      end
    end
  end
end
