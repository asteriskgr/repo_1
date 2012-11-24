Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
  puts User.all
end

Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create(article)
  end
  puts Article.all
end

Given /the following comments exist/ do |feedbacks_table|
  feedbacks_table.hashes.each do |feedback|
    Feedback.create(feedback)
  end
end

Given /comment for article 1 exists/ do
  visit path_to("the home page")
  text = "Flying Parakeets"
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
  link = text
  click_link(link)
  fill_in("comment_body", :with => "Comment 1")
end

Given /am not an admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'blog_publisher_john'
  fill_in 'user_password', :with => 'bbbbbb'
  click_button 'Login'
end

And /^I am an admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin_gordon'
  fill_in 'user_password', :with => 'aaaaaa'
  click_button 'Login'
end
