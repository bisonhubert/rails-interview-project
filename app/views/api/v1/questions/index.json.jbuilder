json.questions @questions do |question|
  json.id question.id
  json.title question.title
  json.asker_id question.user_id
  json.asker question.asker.name
  json.answers question.answers do |answer|
    json.id answer.id
    json.body answer.body
    json.answerer_id answer.user_id
    json.answerer answer.answerer.name
  end
end