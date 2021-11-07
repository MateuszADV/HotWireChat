class MessagesController < ApplicationController
  before_action :set_room, only: %i[ new create ]
  @roomid = 0
  def new
    @message = @room.messages.new

  end

  def show
    puts "testy messages ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  end

  def create

    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts @room.inspect
    @message = @room.messages.create!(message_params)

    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    puts @room.inspect
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    respond_to do |format|
      format.turbo_stream
      format.html {redirect_to @room}
    end
  end

  def destroy
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++"
    puts params[:id]
    @room = Message.find(params[:id])
    puts @room.room.id
    puts "++++++++++++++++++++++++++++++++++++++++++++++++"
    Message.find(params[:id]).destroy!
    respond_to do |format|
      format.turbo_stream
      format.html {redirect_to room_url(@room.room.id)}
      # format.html { redirect_to room_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_room
      puts "((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))"
      puts Room.find(params[:room_id]).to_s
      @room = Room.find(params[:room_id])
    end

    def message_params
      params.require(:message).permit(:content)
    end
end