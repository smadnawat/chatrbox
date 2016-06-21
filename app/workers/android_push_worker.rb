require 'gcm'
class AndroidPushWorker
     include Sidekiq::Worker
     sidekiq_options  :retry => false

  def perform(gadget_id,message)
    p "======gg==#{gadget_id.inspect}=======mm====#{message.inspect}"
  gcm = GCM.new("AIzaSyCwBum-sH4pVPuithjuCMLYb0s0EcgwRXs")
    registration_ids= ["#{gadget_id}"]
    options = {
        'data' => {
          'alert' => message          
         }
    }
    response = gcm.send_notification(registration_ids,options)
    puts "========android=====#{response}==============="
  end
end
 