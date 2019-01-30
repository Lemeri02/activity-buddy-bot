#######################################
# Rake tasks to reset the application #
#######################################

namespace :reset do
  desc "Remove all user data from the DB"
  task full: :environment do
    User.destroy_all
    Conversation.destroy_all
    Message.destroy_all
  end
end