class CreateModels < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :code
    end

    create_table :users do |t|
      t.string :name
      t.references :city
    end
        
    create_table :trips do |t|
      t.datetime    :start_at
      t.datetime    :end_at
      t.boolean     :completed, default: false
      t.references  :user
      t.references  :city
    end

    create_table :reservation_segments do |t|
      t.string      :segment_type
      t.integer     :rank
      t.string      :origin
      t.string      :destination
      t.datetime    :start_at
      t.datetime    :end_at
      t.references  :city
      t.references  :user
      t.references  :trip
    end
        
  end
end
