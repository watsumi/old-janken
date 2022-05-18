# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  role              :integer          not null
#  user_token_digest :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  character_id      :integer          not null
#  game_id           :uuid
#
# Indexes
#
#  index_users_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:game) { create(:game) }
  let(:user_1) do
    create(:user, game:,
                  role: :host,
                  character_id: 1)
  end
  let(:user_2) do
    create(:user, game:,
                  role: :guest,
                  character_id: 1)
  end
  let(:hippogriff) { Character.find(1) }
  let(:yuba) { Character.find(2) }
  let(:carbuncle) { Character.find(3) }

  let(:sand_capital) { Field.where(id: 1..3).sample }
  let(:water_village) { Field.where(id: 4..6).sample }
  let(:grasslands) { Field.where(id: 7..9).sample }

  let(:morning) { Field.where(id: [1, 4, 7]).sample }
  let(:evening) { Field.where(id: [2, 5, 8]).sample }
  let(:night) { Field.where(id: [3, 6, 9]).sample }

  describe '#set_user_token' do
    let(:host) { build(:user, game:, role: 'host') }
    subject do
      host.set_user_token
      game.save!
    end

    it 'user_token_digestが追加されること' do
      expect { subject }.to change {
                              host.user_token_digest
                            }.from(nil).to(be_a_kind_of(String))
    end
  end

  describe '#authenticated?' do
    let(:user) do
      create(:user, game:,
                    role: :host,
                    user_token_digest: BCrypt::Password.create('user_token', cost: BCrypt::Engine::MIN_COST))
    end
    subject { user.authenticated?({ user_token: }) }

    context 'user_tokenが正しい値のとき' do
      let(:user_token) { 'user_token' }
      it { expect(subject).to eq(true) }
    end

    context 'user_tokenが不正な値のとき' do
      let(:user_token) { 'invalid_user_token' }
      it { expect(subject).to eq(false) }
    end
  end

  describe '#set_hand!' do
    let!(:user) do
      create(:user, game:,
                    role: :host,
                    character_id: character.id)
    end

    subject { user.set_hand!(character.name) }

    context 'ヒポグリフのとき' do
      let(:character) { hippogriff }
      it 'グーまたはチョキが選ばれること' do
        subject
        expect(user.user_hands.first.hand_id).to eq(1).or eq(3)
      end
    end
    context 'ユバのとき' do
      let(:character) { yuba }
      it 'グーまたはチョキが選ばれること' do
        subject
        expect(user.user_hands.first.hand_id).to eq(2).or eq(3)
      end
    end
    context 'カーバンクルのとき' do
      let(:character) { carbuncle }
      it 'グーまたはチョキが選ばれること' do
        subject
        expect(user.user_hands.first.hand_id).to eq(1).or eq(2)
      end
    end
  end

  describe '#set_support!' do
    subject { user_1.set_support! }

    it 'サポートカードが紐づくこと' do
      subject
      expect(user_1.user_supports.take.support_id).to eq(1).or eq(2).or eq(3)
    end
  end

  describe '#update_by_support_card!(support_card_id)' do
    subject { user_1.update_by_support_card!(support_card_id) }

    before do
      create_list(:user_hand, 3, user: user_1, hand_id: 1)
      create_list(:user_hand, 3, user: user_2, hand_id: 2)
    end

    context 'support_card が 幸運の妖精チリムとチェリム のとき' do
      let(:support_card_id) { 1 }

      it '自分の手札が一枚更新されること' do
        subject
        expect(UserHand.where(user_id: user_1.id).pluck(:hand_id)).to eq([1, 1, 2]) | eq([1, 1, 3])
      end
    end
    context 'support_card が 幸運の妖精チリムとチェリム のとき' do
      let(:support_card_id) { 2 }

      it '自分の手札が一枚更新されること' do
        subject
        expect(UserHand.where(user_id: user_1.id).pluck(:hand_id)).to eq([1, 1, 2])
      end
    end
    # FIXME: 何かをテストしてるようで何もテストしていない
    context 'support_card が 廃墟の魔女 のとき' do
      let(:support_card_id) { 3 }

      it 'ゲームのフィールドが更新されること' do
        subject
        expect(user_1.game.field_id).to eq(1) | eq(2) | eq(3) | eq(4) | eq(5) | eq(6) | eq(7) | eq(8) | eq(9)
      end
    end
  end

  describe '#win?(user_hand:, enemy_hand:)' do
    subject { user_1.win?(user_hand:, enemy_hand:) }
    context 'userがグーの場合' do
      let(:user_hand) { 1 }
      context 'enemyがグーのとき' do
        let(:enemy_hand) { 1 }
        it 'falseが返ること' do
          expect(subject).to eq(false)
        end
      end

      context 'enemyがパーのとき' do
        let(:enemy_hand) { 2 }
        it 'falseが返ること' do
          expect(subject).to eq(false)
        end
      end

      context 'enemyがチョキのとき' do
        let(:enemy_hand) { 3 }
        it 'trueが返ること' do
          expect(subject).to eq(true)
        end
      end
    end

    context 'userがパーの場合' do
      let(:user_hand) { 2 }
      context 'enemyがグーのとき' do
        let(:enemy_hand) { 1 }
        it 'trueが返ること' do
          expect(subject).to eq(true)
        end
      end

      context 'enemyがパーのとき' do
        let(:enemy_hand) { 2 }
        it 'falseが返ること' do
          expect(subject).to eq(false)
        end
      end

      context 'enemyがチョキのとき' do
        let(:enemy_hand) { 3 }
        it 'falseが返ること' do
          expect(subject).to eq(false)
        end
      end
    end

    context 'userがチョキの場合' do
      let(:user_hand) { 3 }
      context 'enemyがグーのとき' do
        let(:enemy_hand) { 1 }
        it 'falseが返ること' do
          expect(subject).to eq(false)
        end
      end

      context 'enemyがパーのとき' do
        let(:enemy_hand) { 2 }
        it 'trueが返ること' do
          expect(subject).to eq(true)
        end
      end

      context 'enemyがチョキのとき' do
        let(:enemy_hand) { 3 }
        it 'falseが返ること' do
          expect(subject).to eq(false)
        end
      end
    end
  end

  describe '#win_score' do
    let!(:game) { create(:game, field_id: field.id) }
    let!(:user) do
      create(:user, game:,
                    role: :host,
                    character_id: character.id)
    end

    subject { user.win_score }

    context 'ヒポグリフのとき' do
      let(:character) { hippogriff }
      context 'fieldが砂の都とき' do
        let(:field) { sand_capital }
        it '2が返ること' do
          expect(subject).to eq(2)
        end
      end
      context 'fieldが水の村とき' do
        let(:field) { water_village }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが風の街とき' do
        let(:field) { grasslands }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
    end
    context 'ユバのとき' do
      let(:character) { yuba }
      context 'fieldが砂の都とき' do
        let(:field) { sand_capital }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが水の村とき' do
        let(:field) { water_village }
        it '2が返ること' do
          expect(subject).to eq(2)
        end
      end
      context 'fieldが風の街とき' do
        let(:field) { grasslands }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
    end
    context 'カーバンクルのとき' do
      let(:character) { carbuncle }
      context 'fieldが砂の都とき' do
        let(:field) { sand_capital }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが水の村とき' do
        let(:field) { water_village }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが風の街とき' do
        let(:field) { grasslands }
        it '2が返ること' do
          expect(subject).to eq(2)
        end
      end
    end
  end

  describe '#lose_score' do
    let!(:game) { create(:game, field_id: field.id) }
    let!(:user) do
      create(:user, game:,
                    role: :host,
                    character_id: character.id)
    end

    subject { user.lose_score }

    context 'ヒポグリフのとき' do
      let(:character) { hippogriff }
      context 'fieldが朝とき' do
        let(:field) { morning }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが夕方とき' do
        let(:field) { evening }
        it '2が返ること' do
          expect(subject).to eq(2)
        end
      end
      context 'fieldが夜とき' do
        let(:field) { night }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
    end
    context 'ユバのとき' do
      let(:character) { yuba }
      context 'fieldが朝とき' do
        let(:field) { morning }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが夕方とき' do
        let(:field) { evening }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが夜とき' do
        let(:field) { night }
        it '2が返ること' do
          expect(subject).to eq(2)
        end
      end
    end
    context 'カーバンクルのとき' do
      let(:character) { carbuncle }
      context 'fieldが朝とき' do
        let(:field) { morning }
        it '2が返ること' do
          expect(subject).to eq(2)
        end
      end
      context 'fieldが夕方とき' do
        let(:field) { evening }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
      context 'fieldが夜とき' do
        let(:field) { night }
        it '1が返ること' do
          expect(subject).to eq(1)
        end
      end
    end
  end
end
