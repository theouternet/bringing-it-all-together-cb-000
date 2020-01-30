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
    INSERT INTO dogs (name, breed) VALUES (?, ?)
    SQL
  DB[:conn].execute(sql, self.name,self.breed)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
end 
  end 
  
  def self.create(name:, breed:)
    dog = Dog.new(name: name, breed: breed)
    dog.save
    dog
  end 
  
  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    breed = row[2]
    
    self.new(id: id,name: name,breed: breed)

  end 
  
  def self.find_by_id(id)
    sql = <<-SQL
    SELECT *
    FROM dogs
    WHERE id = ?
    SQL
  DB[:conn].execute(sql, id).map do |row|
    self.new_from_db(row)
  end.first 
  end 
  
  def self.find_or_create_by(name:, breed:)
    sql = <<-SQL
    SELECT *
    FROM dogs
    WHERE id = ?
    SQL
  
    if self.id == nil
      self.create(name:, breed:)
    end
     
  end 
  
  def self.find_by_name 
    
  end 
  
  def update
    
  end 
  
end 