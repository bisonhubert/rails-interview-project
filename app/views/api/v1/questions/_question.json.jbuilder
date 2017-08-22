json.extract! question

json.question do
  json.title question.title
  json.asker_id question.user_id
  json.asker question.asker.name
  json.answers question.answers do |answer|
    json.body answer.body
    json.answerer_id answer.user_id
    json.answerer answer.answerer.name
  end
end