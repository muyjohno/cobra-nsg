class RoundsController < ApplicationController
  before_action :set_tournament
  before_action :set_round, only: [:show, :edit, :update, :destroy, :repair, :complete, :start_timer]

  def index
    authorize @tournament, :show?
    @players = @tournament.players.index_by(&:id).merge({ nil => NilPlayer.new })
  end

  def show
    authorize @tournament, :update?
    @players = @tournament.players.index_by(&:id).merge({ nil => NilPlayer.new })
  end

  def create
    authorize @tournament, :update?

    @tournament.pair_new_round!

    redirect_to tournament_rounds_path(@tournament)
  end

  def edit
    authorize @tournament, :update?
  end

  def update
    authorize @tournament, :update?

    @round.update(round_params)

    redirect_to tournament_round_path(@tournament, @round)
  end

  def destroy
    authorize @tournament, :update?

    @round.destroy!

    redirect_to tournament_rounds_path(@tournament)
  end

  def repair
    authorize @tournament, :update?

    @round.repair!

    redirect_to tournament_round_path(@tournament, @round)
  end

  def complete
    authorize @tournament, :update?

    @round.update!(completed: params[:completed])

    redirect_to tournament_rounds_path(@tournament)
  end

  def start_timer
    authorize @tournament, :update?

    @round.update!(length_minutes: params[:length_minutes])
    @round.start_timer!

    redirect_to tournament_rounds_path(@tournament)
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def round_params
    params.require(:round).permit(:weight)
  end
end
