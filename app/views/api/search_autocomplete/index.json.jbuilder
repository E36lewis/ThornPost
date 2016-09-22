json.posts do |json|
  json.array! @posts do |storie|
    json.id storie.id
    json.title truncate(storie.title, length: 38)
    json.avatar_url storie.user.avatar_url.present? ? storie.user.avatar_url : image_path('default-avatar.svg')
    json.url storie_path(storie.slug)
  end
end

json.users do |json|
  json.array! @users do |user|
    json.id user.id
    json.username user.username
    json.avatar_url user.avatar_url.present? ? user.avatar_url : image_path('default-avatar.svg')
    json.url user_path(user.slug)
  end
end

json.tags do |json|
  json.array! @tags do |tag|
    json.id tag.id
    json.name tag.name
    json.url tag_path(tag.slug)
  end
end
