class MoneyTransfering
  include ActiveModel::Model
  include Contracts

  attr_reader :destination, :source, :transfer_params, :amount

  def initialize(transfer_params = {})
    return if transfer_params.empty?

    @transfer_params = transfer_params
    set_source
    set_destination
  end

  def perform(amount, points, admin)
    transfer_money(amount)
    increment_bonus_points(points)
    notify_admin(admin)
  end

  protected

  Contract Num => Any
  def transfer_money(amount)
    source.balance -= amount
    destination.balance += amount
  end

  Contract String => Any
  def transfer_money(amount)
    source.balance -= amount.to_i
    destination.balance += amount.to_i
  end

  def increment_bonus_points(points)
    source.bonus_points += points
  end

  def notify_admin(admin)
    AdminUser.last.notify(self)
  end

  private

  def set_destination
    @destination = Account.find(transfer_params[:destination_id])
  end

  def set_source
    @source = Account.find(transfer_params[:source_id])
  end
end
