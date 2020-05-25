class TimeblocksController < ApplicationController
  def update
    @timeblock = TimeBlock.find(params[:id])
    total_reservations = params[:total_reservations].to_i

    timeblock_chain = TimeBlock
                        .where(
                          "block_start_time >= ?",
                          @timeblock.block_start_time
                        ).where(
                          "block_start_time < ?",
                          (@timeblock.block_start_time + 1.hour + 45.minutes)
                        )

    timeblock_chain.each do |t_block|
      t_block.availability -= total_reservations
      total_reservations.times do
        t_block.users.push(current_user)
      end
      t_block.save!
    end
    #
    # TODO: add timeblock id to user.timeblocks
    #
    redirect_to root_path
  end

  def reserve
    unless user_signed_in?
      redirect_to user_path
      return
    end

    @timeblock = TimeBlock.find(params[:id])
    #
    # timeblock_chain = TimeBlock.where(
    #   "block_start_time <= ?", (timeblock.block_start_time + 1.hour + 45.minutes)
    # )
    # timeblock_chain.each do |t_block|
    #   t_block.availability -= 1
    #   t_block.save!
    # end
    # #
    # # TODO: add timeblock id to user.timeblocks
    # #
    # redirect_to root_path

    # DayBlock.all.each do |d_block|
    #   block_time = d_block.schedule_date.beginning_of_day + 8.hours
    #   end_time = block_time + 12.hours
    #   while block_time < (end_time)
    #     d_block.time_blocks.create(block_start_time: block_time,
    #                                availability: 24)
    #     block_time += 2.hours
    #   end
    # end
  end
end
