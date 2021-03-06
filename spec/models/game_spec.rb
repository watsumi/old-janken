# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  winner     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :integer          default(1), not null
#
require 'rails_helper'

RSpec.describe Game, type: :model do
  include ActionView::RecordIdentifier

  let!(:game)  { create(:game) }
  let!(:host)  { create(:user, game:, role: :host) }
  let!(:guest) { create(:user, game:, role: :guest) }
  let(:game_details) do
    create_list(:game_detail, 3, game:, user: host)
    create_list(:game_detail, 3, game:, user: guest)
  end

  describe '#notify_to_game(message)' do
    let(:message) { 'メッセージの送信確認' }
    subject { game.notify_to_game(message) }

    context '送信成功' do
      it '1通のメッセージが送信されること' do
        expect { subject }.to have_broadcasted_to(dom_id(game, 'flashes')).exactly(:once)
      end
    end
  end

  describe '#show_detail_modal_to_game(host_game_detail, guest_game_detail)' do
    let(:host_game_detail) { create(:game_detail, game:, user: host) }
    let(:guest_game_detail) { create(:game_detail, game:, user: guest) }

    subject { game.show_detail_modal_to_game(host_game_detail, guest_game_detail) }

    context '送信成功' do
      it '1度リクエストが送信されること' do
        expect { subject }.to have_broadcasted_to(dom_id(game, 'detail')).exactly(:once)
      end
    end
  end

  describe '#show_finish_modal_to_game(game_details)' do
    subject { game.show_finish_modal_to_game(game_details) }

    context '送信成功' do
      it '1度リクエストが送信されること' do
        expect { subject }.to have_broadcasted_to(dom_id(game, 'finish')).exactly(:once)
      end
    end
  end

  describe '#winner_role' do
    subject { game.winner_role }

    context 'hostが勝利した場合' do
      before do
        game.update!(winner: host.id)
      end

      it { expect(subject).to eq('hostの勝利です！') }
    end

    context 'guestが勝利した場合' do
      before do
        game.update!(winner: guest.id)
      end

      it { expect(subject).to eq('guestの勝利です！') }
    end

    context '引き分けの場合' do
      before do
        game.update!(winner: 0)
      end

      it { expect(subject).to eq('引き分けです。') }
    end
  end

  describe '#create_game_and_set_user_cards!' do
    let!(:game1) { build(:game) }

    subject { game1.create_game_and_set_user_cards! }

    context '正常系' do
      before do
        @host_user = game1.users.build(role: :host, character_id: 1)
        @guest_user = game1.users.build(role: :guest, character_id: 1)
      end

      it 'userに手札がセットされ、game_detailが1件作成されること' do
        expect do
          expect do
            expect { subject }.to change { @host_user.user_hands.size }.from(0).to(3)
          end.to change { @guest_user.user_hands.size }.from(0).to(3)
        end.to change { game1.game_details.size }.from(0).to(1)
      end
    end
  end

  describe '#turn_end!' do
    subject { game2.turn_end! }

    let!(:game2) { create(:game) }
    let!(:host2)  { create(:user, game: game2, role: :host) }
    let!(:guest2) { create(:user, game: game2, role: :guest) }
    let!(:game_details) do
      create(:game_detail, game: game2, user: host2, hand_id: 1, turn: :host_turn1)
      create(:game_detail, game: game2, user: guest2, hand_id: 2, turn: :guest_turn1)
      create(:game_detail, game: game2, user: host2, hand_id: 1, turn: :host_turn2)
    end

    context 'ゲームが終了していないとき' do
      context 'hostのターンのとき' do
        it 'game_detailが1件新たに作成されること' do
          expect { subject }.to change { game2.game_details.size }.by(1)
        end
      end
      context 'guestのターンのとき' do
        before do
          create(:game_detail, game: game2, user: guest2, hand_id: 2, turn: :guest_turn2)
        end
        it 'game_detailが1件新たに作成され、round_scoreが更新されること' do
          subject

          host_round_score = game2.game_details.third_to_last.round_score
          guest_round_score = game2.game_details.second_to_last.round_score

          expect(host_round_score).to eq(-1)
          expect(guest_round_score).to eq(2)
        end
      end
    end

    context 'gameが終了しているとき' do
      before do
        allow(game2).to receive(:game_judge!).and_return(true)

        create(:game_detail, game: game2, user: guest2, hand_id: 2, turn: :guest_turn2)
        create(:game_detail, game: game2, user: host2, hand_id: 2, turn: :host_turn3)
        create(:game_detail, game: game2, user: guest2, hand_id: 2, turn: :guest_turn3)
      end

      it '#game_judge!メソッドが呼ばれること' do
        subject
        expect(game2).to have_received(:game_judge!).once
      end
    end
  end

  describe '#cpu_turn_activate!' do
    subject { game3.cpu_turn_activate! }

    let!(:game3) { create(:game) }
    let!(:host3)  { create(:user, game: game3, role: :host) }
    let!(:guest3) { create(:user, game: game3, role: :guest, user_token_digest: 'cpu_token') }
    let!(:guest_hand) { create_list(:user_hand, 2, user: guest3) }
    let!(:guest_support) { create(:user_support, user: guest3) }
    let!(:game_details) do
      create(:game_detail, game: game3, user: host3, hand_id: 1, turn: :host_turn1)
      create(:game_detail, game: game3, user: guest3, hand_id: 2, turn: :guest_turn1)
    end

    context 'supportカードが使用されていないとき' do
      it 'supportカードが使用されること' do
        expect { subject }.to change { guest3.user_supports.size }.from(1).to(0)
      end
    end

    it 'handカードが使用されること' do
      expect { subject }.to change { guest3.user_hands.size }.by(-1)
    end

    context 'Roundが3以外のとき' do
      it 'hostのターンになること' do
        subject
        expect(game3.game_details.last.host_turn?).to be_truthy
      end
    end

    context 'Roundが3のとき' do
      before do
        create(:game_detail, game: game3, user: host3, hand_id: 1, turn: :host_turn2)
        create(:game_detail, game: game3, user: host3, hand_id: 1, turn: :host_turn3)
        create(:game_detail, game: game3, user: guest3, hand_id: 2, turn: :guest_turn2)
        create(:game_detail, game: game3, user: guest3, hand_id: 2, turn: :guest_turn3)
      end

      it 'ゲームが終了すること' do
        subject
        expect(game3.game_details.last.finished?).to be_truthy
      end
    end
  end

  describe '#game_judge!' do
    subject { game.game_judge! }

    let!(:game_details) do
      create_list(:game_detail, 3, game:, user: host, round_score: host_round_score)
      create_list(:game_detail, 3, game:, user: guest, round_score: guest_round_score)
    end

    context 'hostの勝利の場合' do
      let(:host_round_score) { 2 }
      let(:guest_round_score) { -2 }

      it 'gameのwinnerがhostになること' do
        expect { subject }.to change { game.winner }.from(nil).to(host.id)
      end
    end

    context 'guestの勝利の場合' do
      let(:host_round_score) { -2 }
      let(:guest_round_score) { 2 }

      it 'gameのwinnerがguestになること' do
        expect { subject }.to change { game.winner }.from(nil).to(guest.id)
      end
    end

    context '引き分けの場合' do
      let(:host_round_score) { 2 }
      let(:guest_round_score) { 2 }

      it 'gameのwinnerが0になること' do
        subject
        expect(game.winner).to eq('0')
      end
    end
  end
end
