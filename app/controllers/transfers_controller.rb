class TransfersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_amount, :set_points, :set_admin, only: :create

  def new
    @transfer = MoneyTransfering.new
  end

  def create
    @transfer = MoneyTransfering.new(transfer_params)

    if @transfer.perform(@amount, @points, @admin)
      redirect_to transfers_path, notice: 'Всё ок'
    else
      flash.now[:error] = 'Ошибка при переводе средств'
      render :new
    end
  end

  private

  def transfer_params
    params.require(:money_transfering)
          .permit(:source_id, :destination_id, :amount)
  end

  def set_amount
    # AmounCalculator.new.generate_amount
    @amount = [100, '100', '200', nil].sample
  end

  def set_points
    # PointsCalculator.new.generate_amount
    @points = 100
  end

  def set_admin
    @admin = AdminUser.first
  end

end
