 class DigestEmailWorker
   include Sidekiq::Worker
   include Sidetiq::Schedulable
   sidekiq_options :queue => :mailer

   recurrence { monthly.day_of_week(5).hour_of_day(12) }

   def perform
     User.find_each do |user|
       DigestMailer.daily_email(user).deliver_now
     end
   end
 end