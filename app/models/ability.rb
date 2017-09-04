class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.persisted?
      can :read, :all
      cannot :read, Order
      can :read, Review, status: true
      can :read, Order, user_id: user.id
      can :create, Review
      can %i[create update], [Order, OrderItem, Address, CreditCard], user_id: user.id
    else
      can :read, [Review, Book, Image]
      can %i[create read update], Order, OrderItem
    end
  end
end