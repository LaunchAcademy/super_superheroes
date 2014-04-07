require 'spec_helper'

describe Movie do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:year)}
  it { should validate_presence_of(:superhero)}

  it { should have_valid(:year).when("2008", "1997")}
  it { should_not have_valid(:year).when("97", "", nil)}

  it { should have_valid(:mpaa_rating).when("", nil, "R")}
  it { should_not have_valid(:mpaa_rating).when("peegee")}

  describe "#average_rating" do
    it "returns a movie's average rating" do
      movie = FactoryGirl.create(:movie)
      [1, 2, 4].each {|x| FactoryGirl.create(:review, movie: movie, rating: x) }
      expect(movie.average_rating).to eq(2.33)

      new_movie = FactoryGirl.create(:movie)
      expect(new_movie.average_rating).to eq(0)
    end
  end

  describe 'Admin actions' do
    it 'deletes reviews when movie is deleted' do
      movies = FactoryGirl.create_list(:movie, 2)
      FactoryGirl.create_list(:review, 3, movie: movies[0])
      FactoryGirl.create_list(:review, 3, movie: movies[1])
      movies[0].destroy

      expect(Review.count).to eq(3)
    end
  end

end
