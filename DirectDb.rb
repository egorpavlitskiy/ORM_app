require 'pg'

class DirectDB

  def connect_db
    @connect = PG.connect :dbname => 'postdb', :user => 'postuser', :password => '12345'
  end

  def select_all
    inquiry = "SELECT * FROM #{tb_name}"
    connect_db.exec(inquiry) do |result|
      result.each { |e|
        p e
      }
    end
    @connect.close
  end

  def add_entry (params)
    values = Array.new
    columns = Array.new
    params.each{|key, value| columns.push(key.to_s); values.push("'#{value.to_s}'")}
    columns = columns.join(", ")
    values = values.join(", ")
    inquiry = "INSERT INTO #{tb_name} (#{columns}) values (#{values})"
    connect_db.exec(inquiry)
    @connect.close
  end

  def delete_entry(id)
    connect_db.exec("DELETE FROM #{tb_name} WHERE id=#{id}")
    @connect.close
  end

  def update_entry(params, id)
    updates = Array.new
    params.each {|key, val| updates.push("#{key} = '#{val}'")}
    updates = updates.join(", ")
    inquiry = "UPDATE #{tb_name} SET #{updates} WHERE id=#{id} "
    connect_db.exec(inquiry)
    @connect.close
  end

  def tb_name
    tb_name = self.class.to_s.downcase + "s"
  end

end
