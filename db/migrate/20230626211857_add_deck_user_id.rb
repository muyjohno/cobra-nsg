class AddDeckUserId < ActiveRecord::Migration[7.0]
  def change
    add_reference :decks, :user
    Deck.all.each do |deck|
      deck.update(user_id: deck.player.user_id)
    end
  end
end
