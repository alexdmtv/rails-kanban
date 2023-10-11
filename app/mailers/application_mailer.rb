class ApplicationMailer < ActionMailer::Base
  default from: 'Rails Kanban App <app@intelylabs.com>',
          message_stream: 'outbound',
          track_opens: 'true'
  layout 'mailer'
end
