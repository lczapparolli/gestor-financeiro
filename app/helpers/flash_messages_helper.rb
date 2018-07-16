module FlashMessagesHelper

  def flash_messages
    keys = [:success, :default, :warning, :alert]
    
    unless flash.empty?

      content_tag(:div, class: "messages") do
        messages(keys)
      end

    end
  end

  def messages(keys)
    messages = ""

    keys.each do |type|
      if flash[type]
        messages << content_tag(:span, flash[type], class: type.to_s()) 
      end
    end

    sanitize(messages)
  end

end