require 'pg'

class DirectDB

  def connect_db
    @connect = PG.connect :dbname => 'postdb', :user => 'postuser', :password => '12345'
  end

  def select_all
    connect_db.exec("SELECT * FROM notes") do |result|

      result.each { |e|
        p e
      }
    end
    @connect.close
  end

  def add_entry (params)
    connect_db.exec("INSERT INTO notes (title, description) values ('#{params[:title]}', '#{params[:description]}')")
    @connect.close
  end

  def delete_entry(id)
    connect_db.exec("DELETE FROM notes WHERE id=#{id}")
    @connect.close
  end

  def update_entry(params)
    connect_db.exec("UPDATE notes SET title='#{params[:title]}', description='#{params[:description]}' WHERE id=#{params[:id]} ")
    @connect.close
  end

end

param = {:title => 'Poo' , :description => 'Little story for child'}
param_update = {:id => 7, :title => 'Poo' , :description => 'Little story for child'}

# app = Postgres_direct.new
# app.add_entry(param)
# app.select_all
# app.delete_entry(5)
# app.update_entry(param_update)