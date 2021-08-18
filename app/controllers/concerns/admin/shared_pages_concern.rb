module Admin::SharedPagesConcern
  extend ActiveSupport::Concern

  def accessibility_statement
    render "#{self.class.module_parent.module_parent.to_s.underscore}/home/accessibility_statement"
  end

  def cookie_policy
    render 'home/cookie_policy'
  end

  def cookie_settings
    render 'home/cookie_settings'
  end
end
