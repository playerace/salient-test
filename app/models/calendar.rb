class Calendar < ActiveRecord::Base
  attr_accessible :year, :month, :day, :hour, :minute, :prefix

  PARAMS = %w(year month day hour minute)
  MONTHS = %w(january february march april may june july august september october november december)


  def parse_and_save(str = nil)
    return  if str.nil?

    # parse prefix
    if str.match(/^(After|Before)\s/i)
      case str.match(/^(After|Before)\s/)[1]
        when "After"
          self.prefix = 1
        when "Before"
          self.prefix = -1
      end
      str.gsub!(/^(After|Before)\s/i,'')
    end
    

    begin
      time = Time.parse(str)
      # PARAMS.each do |param|
      #   self.try(param) = time.try(param)
      # end
      if str.match(/\d{4}/)
        self.year = time.year
      end
      if str.match(/(#{MONTHS.join('|')})/i)
        self.month = time.month
      end
      if str.match(/\d{2} (#{MONTHS.join('|')})/i)
        self.day = time.day
      end
      if str.match(/\d{2}:\d{2}/)
        self.hour = time.hour
        self.minute = time.min
      end
      if str.match(/\d{2}\s*?(am|pm)/i)
        self.hour = time.hour
      end
    rescue Exception
      if str.match(/^\d{4}$/)
        self.year = str.match(/^\d{4}$/)[0]
      end
    end
    self
  end

  def say
    str = if self.year && self.month && self.day && self.hour && self.minute
      t = Time.new(self.year, self.month, self.day, self.hour, self.minute)
      t.strftime("%I:%M %p, %A, %d %B %Y")
    elsif self.year && self.month && self.day && self.hour
      t = Time.new(self.year, self.month, self.day, self.hour)
      t.strftime("%I:%M %p, %A, %d %B %Y")
    elsif self.year && self.month && self.day
      t = Time.new(self.year, self.month, self.day)
      t.strftime("%A, %d %B %Y")
    elsif self.year && self.month
      t = Time.new(self.year, self.month)
      t.strftime("%B %Y")
    elsif self.year
      self.year
    end

    case self.prefix
      when -1
        "Before #{str}"
      when 1
        "After #{str}"
      else
        str
    end
  end
end
