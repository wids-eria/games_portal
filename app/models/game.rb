class Game < ActiveRecord::Base
  attr_accessible :name,:path,:description,:image,:file,:lesson_plan,:cirriculum,:survey,
  :survey_attributes,:about,:localpath,:microsite,:external_download,:token

  has_attached_file :image, :default_url => "/images/:style/missing.png"
  has_attached_file :file
  has_attached_file :lesson_plan
  has_attached_file :cirriculum

  has_one :survey
  accepts_nested_attributes_for :survey

  validates_uniqueness_of :name,:path
  validates_presence_of :name,:path,:description,:token
  validate :is_valid_token

  validates_attachment_presence :image
  validates_attachment :image, content_type: {:content_type => ['image/png','image/jpg','image/jpeg']}
  validates_attachment_content_type :file, content_type: ['application/x-shockwave-flash','application/octet-stream']

  def has_data(user)
    #return !AdaData.with_game(self.path).where(user_id: user.ada_id).last.nil?
    return !AdaData.with_game(self.get_ada_name).last.nil?
  end

  def last_playtime(user)
    #return AdaData.with_game(self.path).where(user_id: user.ada_id).last.timestamp
    return AdaData.with_game(self.get_ada_name).last.timestamp
  end

  def play_data(user)
    @users = [user]

    map = %Q{
      function(){
        var key = {user_id: this.user_id,session: this.session_token};
        var data = {start:this.timestamp,end:this.timestamp};
        emit(key,data);
      }
    }

    reduce = %Q{
      function(key,values){
        var results = {start: null,end:0};

        values.forEach(function(value){
            if(results.start == null) results.start = value.start;
            results.end = value.end;
        });

        return results;
      }
    }

    @average_time = 0
    @session_count = 0
    #Check for the ADAVersion for compatability before all the processing
    log = AdaData.with_game(self.get_ada_name).only(:_id,:ADAVersion).where(:ADAVersion.exists=>true).first

    unless log.nil?
      drunken_dolphin = log.ADAVersion.include?('drunken_dolphin')
      logs = AdaData.with_game(self.get_ada_name).order_by(:timestamp.asc).in(user_id: user.id).only(:ADAVersion,:timestamp,:user_id,:session_token).where(:ADAVersion.exists=>true).map_reduce(map,reduce).out(inline:1)

      sessions_played = 0
      total_session_length = 0
      last_user = -1
      index = -1

      session_time = Hash.new
      logs.each do |log|
        log_user = log["_id"]["user_id"].to_i
        if(log_user != last_user)
          session_time = Hash.new
          last_user = log_user
          index += 1
        end

        if drunken_dolphin
          start_time = log["value"]["start"]
          end_time = log["value"]["end"]

          if start_time.is_a? String
            start_time = start_time.to_i
            end_time = end_time.to_i
          end

          start_time = Time.at(start_time).to_i
          end_time = Time.at(end_time).to_i
        else
          start_time = DateTime.strptime(log["value"]["start"], "%m/%d/%Y %H:%M:%S").to_time.to_i
          end_time = DateTime.strptime(log["value"]["end"], "%m/%d/%Y %H:%M:%S").to_time.to_i
        end
        minutes = (end_time - start_time)/1.minute.round
        session_time[start_time] = minutes

        total_session_length += minutes
        sessions_played += 1
      end

      unless sessions_played == 0
        @average_time = total_session_length/sessions_played
      else
        @average_time = 0
      end
      @session_count = sessions_played
      @total_time = total_session_length
      return {average_time: @average_time, sessions: @session_count, total_time: @total_time}
    end
    return nil
  end

  def get_ada_name
    on_db :adage do
      name =  Client.find_by_app_token(self.token.strip).implementation.game.name
    end
    return name
  end

  def is_valid_token
    if Client.find_by_app_token(self.token.strip).nil?
      errors.add(:token, 'No Adage game exists for token')
    end
  end
end