require 'spec_helper'

describe Review do
  let!(:review) {FactoryGirl.build(:review)}

  it { should have_valid(:rating).when(2, 3, 5)}
  it { should_not have_valid(:rating).when(nil, "three", "")}
  it { should have_valid(:body).when(review.body, nil, "")}
  it { should belong_to(:movie)}

  describe "#net_votes" do

    before :each do
      @review = FactoryGirl.create(:review)
      @review2 = FactoryGirl.create(:review)
      FactoryGirl.create_list(:vote, 2, review: @review2, value: "Up")
      FactoryGirl.create_list(:vote, 3, review: @review2, value: "Down")
    end

    it 'calculates the net upvotes' do
      expect(@review2.net_votes).to eq(-1)
    end

    it 'allows us to sort reviews by this amount' do
      expect(Review.all.sort_by(&:net_votes).first).to eq(@review2)
    end
  end
end
