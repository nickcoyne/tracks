module DefaultHelper

  def not_logged_in
    logout_user
  end

  def login_user
    if @current_user.nil?
      @current_user = prepare_user
    end
    session[:current] = 'this_session_id'
    controller.stub(:current_user).and_return(@current_user)
  end

  def login_admin
    login_user
    @current_user.has_role! :admin
    @current_user.stub(:roles).and_return(@current_user.role_objects)
    return @current_user
  end

  def login_client
    login_user
    @current_user.has_role! :client
    @current_user.stub(:roles).and_return(@current_user.role_objects)
    return @current_user
  end

  def logout_user
    @current_user = nil
    @current_user.stub(:current_session).and_return(nil )
    controller.stub(:current_user).and_return(nil)
    controller.stub(:logged_in?).and_return(false)
  end

  def prepare_user
    user = Factory.build(:user)
    user.stub(:current_session).and_return('this_session_id')
    user.stub(:forget_me).and_return(false)
    user.stub(:roles).and_return([])
    user
  end

  def validate_with(attributes)
    ValidateWith.new(attributes)
  end

  def use_layout(expected)
    UseLayout.new(expected)
  end

end

class ValidateWith

  def initialize(attributes)
    @attributes = attributes
  end

  def matches?(target)
    @target = target
    # satisfy should expectation here
    @target.attributes = @attributes
    @target.valid?
  end

  def failure_message
    "expected #{ @target.inspect } to be valid with #{ @attributes.inspect } but got these #{ @target.errors.full_messages.join(',') } errors"
  end

  def negative_failure_message
    "expected #{ @target.inspect } to not be valid with #{ @attributes.inspect } but got no errors"
  end

end

class UseLayout

  def initialize(expected)
    @expected = 'layouts/' + expected
  end

  def matches?(controller)
    @actual = controller.layout
    @actual == @expected
  end

  def failure_message
    return "use_layout expected #{ @expected.inspect }, got #{ @actual.inspect }", @expected, @actual
  end

  def negeative_failure_message
    return "use_layout expected #{ @expected.inspect } not to equal #{ @actual.inspect }", @expected, @actual
  end

end