  require "active_support/core_ext/string/output_safety"

  class ERB
    module Util
      # see https://github.com/rails/rails/issues/7430
      # https://gist.github.com/grosser/599b47bea7f3c5a044cb
      def html_escape(s)
        s = s.to_s
        if s.html_safe?
          s
        else
          s.gsub(/[&"'><]/, HTML_ESCAPE).html_safe
        end
      end

      alias h html_escape

      singleton_class.send(:remove_method, :html_escape)
      module_function :html_escape, :h
    end
  end