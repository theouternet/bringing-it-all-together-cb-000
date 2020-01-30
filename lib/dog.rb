class Dog 
  
  attr_accessor :name, :breed, :id
  
  def initialize(id: nil, name:, breed:)
    @name = name 
    @breed = breed
    @id = id
  end 

  
  def self.create_table 
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table 
    sql = <<-SQL
    DROP TABLE IF EXISTS dogs
    SQL
    DB[:conn].execute(sql)
  end 
  
  def save 
    if self.id 
      self.update
    else 
    sql = <<-SQL
    INSERT INTO dogs (name, breed)
    VALUES (?,?)
    SQL
  DB[:conn].execute(sql, self.name,self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  end 
  
  def self.create(name, breed)
    dog = Dog.new(name, breed)
    dog.save
  end 
  
  def self.new_from_db 
    sql = <<-SQL
   SELECT *
   FROM dogs
   (name, breed)
    VALUES (?,?)
    SQL
    Dog.new
  end 
  
  def self.find_by_id
    
  end 
  
  def self.find_or_create_by
    
  end 
  
  def self.find_by_name 
    
  end 
  
  def update
    
  end 
  
end 