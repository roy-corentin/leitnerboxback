require "../../../spec_helper"

describe Api::LeitnerBoxes::CreateDefault do
  describe "user authenticated" do
    it "return the default leitner_box" do
      user = UserFactory.create

      response = ApiClient.auth(user).exec(Api::LeitnerBoxes::CreateDefault, leitner_box: valid_params())

      response.should send_json(201, name: "TestBox")

      leitner_box = LeitnerBoxQuery.new.first
      leitner_box_with_decks = LeitnerBoxQuery.preload_decks(leitner_box)

      leitner_box_with_decks.decks.size.should eq(5)

      leitner_box_with_decks.decks[0].period_type.should eq(Deck::Period::Week)
      leitner_box_with_decks.decks[0].period_unit.should eq(7)
      leitner_box_with_decks.decks[0].level.should eq(1)

      leitner_box_with_decks.decks[1].period_type.should eq(Deck::Period::Week)
      leitner_box_with_decks.decks[1].period_unit.should eq(3)
      leitner_box_with_decks.decks[1].level.should eq(2)

      leitner_box_with_decks.decks[2].period_type.should eq(Deck::Period::Week)
      leitner_box_with_decks.decks[2].period_unit.should eq(1)
      leitner_box_with_decks.decks[2].level.should eq(3)

      leitner_box_with_decks.decks[3].period_type.should eq(Deck::Period::Month)
      leitner_box_with_decks.decks[3].period_unit.should eq(2)
      leitner_box_with_decks.decks[3].level.should eq(4)

      leitner_box_with_decks.decks[4].period_type.should eq(Deck::Period::Month)
      leitner_box_with_decks.decks[4].period_unit.should eq(1)
      leitner_box_with_decks.decks[4].level.should eq(5)
    end
  end
end

private def valid_params
  {
    name: "TestBox",
  }
end
