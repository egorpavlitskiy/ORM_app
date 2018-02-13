require_relative 'DirectDb'

class Note < DirectDB

end

app = Note.new
app.select_all
