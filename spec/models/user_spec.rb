require "rails_helper"

describe User do
  describe "relationship" do
    it "shoud have many readings" do
      t = User.reflect_on_association :readings
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
    it "shoud have many comments" do
      t = User.reflect_on_association :comments
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
    it "shoud have many requests" do
      t = User.reflect_on_association :requests
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
    it "shoud have many reviews" do
      t = User.reflect_on_association :reviews
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
    it "shoud have many likes" do
      t = User.reflect_on_association :likes
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
    it "shoud have many activities" do
      t = User.reflect_on_association :activities
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
    end
  it "shoud have many active_relationships" do
      t = User.reflect_on_association :active_relationships
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
      expect(t.options[:class_name]).to eq Relationship.name
      expect(t.options[:foreign_key]).to eq "follower_id"
    end
  it "shoud have many passive_relationships" do
      t = User.reflect_on_association :passive_relationships
      expect(t.macro).to eq :has_many
      expect(t.options[:dependent]).to eq :destroy
      expect(t.options[:class_name]).to eq Relationship.name
      expect(t.options[:foreign_key]).to eq "followed_id"
    end
  end

  describe "functions" do
    let(:user) {FactoryGirl.create :user}
    let(:books) {FactoryGirl.create_list :book, 6}
    describe "after initial" do
      it "should have normal role" do
        expect(user.role).to eq "normal"
      end
    end
    describe "add favorite book" do
      before do
        books[0..2].each {|book| user.add_favorite book}
      end
      it "should return book has been added" do
        expect(user.favorited_books).to include *books[0..2]

        books[0..2].each do |book|
          expect(user.added_favorite?(book)).to eq true
        end

        books[3..5].each do |book|
          expect(user.added_favorite?(book)).to eq false
        end
      end
    end

    describe "check reading book" do
      let(:reading_books) {books.sample(3)}
      before do
        reading_books.each {|book| user.readings.create book: book}
      end
      it "should return true" do
        reading_books.each do |book|
          expect(user.added_reading?(book)).to eq true
        end
      end
    end

    describe "find status" do
      context "with reading_book" do
        let(:reading_book) {books[0]}
        let(:readed_book) {books[1]}
        before do
          user.readings.create book: reading_book
          user.readings.create book: readed_book, status: :readed
        end
        it "should return book status" do
          expect(user.find_status(reading_book)).to eq "reading"
          expect(user.find_status(readed_book)).to eq "readed"
        end
      end

      context "with un-reading book" do
        it "should return 'unread'" do
          books.each do |book|
            expect(user.find_status(book)).to eq "unread"
          end
        end
      end
    end

    describe "follow/unfollow other user" do
      let(:other_users) {FactoryGirl.create_list :user, 5}
      before do
        other_users.each {|other_user| user.follow other_user}
        user.unfollow other_users[4]
      end
      it "should check follow user" do
        other_users[0..3].each do |other_user|
          expect(user.following?(other_user)).to eq true
        end
        expect(user.following?(other_users[4])).to eq false
      end
    end
  end
end
