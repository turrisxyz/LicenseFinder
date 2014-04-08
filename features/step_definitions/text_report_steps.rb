Given(/^I have an app with license finder that depends on a gem with license and version details$/) do
  @user = ::DSL::User.new
  @user.create_nonrails_app
  @user.create_and_depend_on_gem('info_gem', license: 'MIT', version: '1.1.1')
end

Given(/^I have a dependencies\.txt file$/) do
  @user.app_path("doc").mkpath

  @user.app_path("doc/dependencies.txt").open('w+') { |file| file.puts("Legacy text file") }
end

Then(/^I should see those version and license details in the dependencies\.csv file$/) do
  @user.app_path("doc/dependencies.csv").read.should include "info_gem, 1.1.1, MIT"
end

Then(/^I should see dependencies\.txt replaced by dependencies\.csv$/) do
  @user.app_path("doc/dependencies.txt").should_not be_exist
  @user.app_path("doc/dependencies.csv").should be_exist
end
