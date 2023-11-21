class LeitnerBoxQuery < LeitnerBox::BaseQuery
  def card_ids(leitner_box_id)
    sql = <<-SQL
    SELECT cards.id
    FROM cards
    JOIN decks ON cards.deck_id =  decks.id
    JOIN leitner_boxes ON decks.leitner_box_id = leitner_boxes.id
    WHERE leitner_boxes.id = $1;
    SQL

    AppDatabase.query_all(sql, args: [leitner_box_id], as: Int64)
  end
end
