class UserPresenter
  extend Forwardable
  def_delegators :@user, :email
  def initialize(user)
    @user = user
  end
  def event_series
    #TBC
    MetaEvent.all
  end
end
