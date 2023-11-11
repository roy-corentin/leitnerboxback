class Api::LeitnerBoxes::Delete < ApiAction
  delete "/leitner_boxes/:leitner_box_id" do
    leitner_box = LeitnerBoxQuery.new.id(leitner_box_id).user_id(current_user.id).first
    DeleteLeitnerBox.delete!(leitner_box)

    json({ok: "LeitnerBox successfully deleted"})
  end
end
