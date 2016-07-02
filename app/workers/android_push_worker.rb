require 'gcm'
class AndroidPushWorker
     include Sidekiq::Worker
     sidekiq_options  :retry => false

  def perform(gadget_id,user,message_id,message_content,user_id,chatroom_or_member_id,created_at,type,media,chatroom_name)
    # p "======gg==#{gadget_id.inspect}=======mm====#{message.inspect}==========obj========"
  gcm = GCM.new("AIzaSyCwBum-sH4pVPuithjuCMLYb0s0EcgwRXs")
    registration_ids= ["#{gadget_id}"]
     if (type == "GroupChat")
         p "====in group chat="
    options = {
        'data' => {
          'user'=>user,
          'message_id'=>message_id, 
          'content'=>message_content,
          'user_id'=>user_id,
          'chatroom_id'=>chatroom_or_member_id,
          'created_at'=>created_at,
          'group_name'=>chatroom_name
          'type'=>type      
         }
    }

  elsif(type =="SingleChat")
      p "============in single chat"
     options = {
        'data' => {
          'user'=>user,
          'message_id'=>message_id, 
          'content'=>message_content,
          'user_id'=>user_id,
          'member_id'=>chatroom_or_member_id,
          'created_at'=>created_at,
          'media'=>media,
          'type'=>type      
         }
    }
  end
    response = gcm.send_notification(registration_ids,options)
    puts "========android=====#{response}====#{options}==========="
  end
end
 