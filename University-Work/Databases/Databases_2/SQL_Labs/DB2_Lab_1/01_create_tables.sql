-- Create Movies table
CREATE TABLE Movies (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,    
  title TEXT NOT NULL,    
  year INTEGER NOT NULL,    
  rating INTEGER DEFAULT 1
);   

-- Create Genres table
CREATE TABLE Genres (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,    
  name TEXT NOT NULL
);    

-- Create MoviesGenres table
CREATE TABLE MoviesGenres (
  m_id INTEGER NOT NULL,   
  g_id INTEGER NOT NULL
);

-- Add foreign key constraint for MoviesGenres (m_id referencing Movies)
ALTER TABLE MoviesGenres 
  ADD CONSTRAINT FK_Movies FOREIGN KEY (m_id) REFERENCES Movies(id);

-- Add foreign key constraint for MoviesGenres (g_id referencing Genres)
ALTER TABLE MoviesGenres 
  ADD CONSTRAINT FK_Genres FOREIGN KEY (g_id) REFERENCES Genres(id);

