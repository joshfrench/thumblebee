module ApplicationHelper
  def errors_on(obj)
    object = instance_variable_get "@#{obj}"
    count   = [object].inject(0) {|sum, object| sum + object.errors.count }
    unless count.zero?
      errors = {}
      object.errors.each do |att,msg|
        next if msg.nil?
        # only grabs first error, hopefully you've ordered them
        # to be meaningful in your model
        errors[att] ||= msg unless errors.value?(msg)
      end
      error_messages = errors.map { |e,msg| content_tag(:li, msg) }.reverse.join "\n"
      out = "<div class='errors'><h3>Oops...</h3>";
      out << content_tag( :ul, error_messages )
      out << "\n</div>"
      out
    end
  end
  
  def seat_hint_for(ride)
    unless ride.new_record?
      @class = ' class="hint"'
      @text = content_tag 'p', 'Set this to 0 to hide your listing.'
    end
    "<td#{@class}>#{@text}</td>"
  end
  
  def event_image(event)
    image_tag("#{event.slug}.gif") if File.exists?(File.join(RAILS_ROOT, 'public', 'images', "#{event.slug}.gif"))
  end
end

class ActionView::Helpers::FormBuilder
  def hint_or_error_for(field, hint)
    @object.errors.on(field) || hint
  end
  
  def hint_or_error_td_for(field, hint)
    style = @object.errors.on(field) ? 'hint error' : 'hint'
    "<td class=\"#{style}\"><p>#{hint_or_error_for(field, hint)}</p></td>"
  end
  
  def blank_or_error_td_for(field)
    style = @object.errors.on(field) ? ' class="hint error"' : nil
    "<td#{style}><p>#{@object.errors.on field}</p></td>"
  end
end