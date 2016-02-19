When(/^I run rake (\w*) with:$/) do |name, task_def|
  rake(name, task_def)
end
