module DefaultHelper

  def login_user
    @current_user = prepare_user if @current_user.nil?
    session[:user] = 'this_session_id'
    controller.stub!(:current_user).and_return(@current_user)
  end

  # def login_admin
  #   login_user
  #   return @current_user
  # end

  def prepare_user
    user = Factory.build(:user)
    user.stub!(:current_session).and_return('this_session_id')
    user.stub!(:forget_me).and_return(false)
    user
  end

  def logout_user
    @current_user = nil
    controller.stub(:current_user).and_return(nil)
    controller.stub(:logged_in?).and_return(false)
  end

  # def validate_with(attributes)
  #   ValidateWith.new(attributes)
  # end

  # def use_layout(expected)
  #   UseLayout.new(expected)
  # end

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