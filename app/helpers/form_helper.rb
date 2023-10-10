module FormHelper
  def field_errors(object, field)
    tag.p class: 'text-red text-body-l' do
      object.errors.full_messages_for(field).join(', ')
    end
  end
end
