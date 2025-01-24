class Task
  property title : String
  property done : Bool = false
  property id : Int32

  def initialize(title : String, id : Int32)
    @title = title
    @id = id
  end

  def <=>(other : Task) : Int32
    @title <=> other.title
  end
end
