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
        errors[att] ||= msg
      end
      error_messages = errors.map { |e,msg| content_tag(:li, msg) }.reverse.join "\n"
      out = "<div class='errors'><h3>Oops...</h3>";
      out << content_tag( :ul, error_messages )
      out << "\n</div>"
      out
    end
  end
end
