module FlashHelper
  def flash_message_classes(flash_key)
    case flash_key.to_sym
    when :alert, :error
      'text-red'
    else
      'text-main-purple'
    end
  end

  def flash_btn_classes(flash_key)
    case flash_key.to_sym
    when :alert, :error
      'hover:bg-red-hover focus:ring-offset-red/40 focus:ring-red/30'
    else
      'hover:bg-main-purple-hover focus:ring-offset-main-purple/40 focus:ring-main-purple/30'
    end
  end

  def flash_icon(flash_key)
    case flash_key.to_sym
    when :alert, :error
      raw '<svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
        <path fill-rule="evenodd" d="M8.485 2.495c.673-1.167 2.357-1.167 3.03 0l6.28 10.875c.673 1.167-.17 2.625-1.516 2.625H3.72c-1.347 0-2.189-1.458-1.515-2.625L8.485 2.495zM10 5a.75.75 0 01.75.75v3.5a.75.75 0 01-1.5 0v-3.5A.75.75 0 0110 5zm0 9a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
      </svg>'.html_safe
    else
      raw '<svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a.75.75 0 000 1.5h.253a.25.25 0 01.244.304l-.459 2.066A1.75 1.75 0 0010.747 15H11a.75.75 0 000-1.5h-.253a.25.25 0 01-.244-.304l.459-2.066A1.75 1.75 0 009.253 9H9z" clip-rule="evenodd" />
      </svg>'.html_safe
    end
  end
end

