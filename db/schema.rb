# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 12) do

  create_table "areas", :force => true do |t|
    t.column "name",        :string,   :limit => 40,                               :default => "",  :null => false
    t.column "state_id",    :integer
    t.column "date",        :datetime
    t.column "description", :string
    t.column "zoom",        :integer,                                              :default => 0
    t.column "latitude",    :decimal,                :precision => 9, :scale => 6, :default => 0.0
    t.column "longitude",   :decimal,                :precision => 9, :scale => 6, :default => 0.0
  end

  create_table "conditions", :force => true do |t|
    t.column "name", :string
  end

  create_table "nations", :force => true do |t|
    t.column "name",        :string,   :limit => 40, :default => "", :null => false
    t.column "description", :string,                 :default => ""
    t.column "date",        :datetime
  end

  add_index "nations", ["name"], :name => "index_nations_on_name", :unique => true

  create_table "specials", :force => true do |t|
    t.column "name",    :string
    t.column "content", :string
  end

  create_table "states", :force => true do |t|
    t.column "name",          :string,   :limit => 40,                               :default => "",  :null => false
    t.column "nation_id",     :integer
    t.column "date",          :datetime
    t.column "description",   :string
    t.column "rain_readings", :integer
    t.column "zoom",          :integer,                                              :default => 0
    t.column "latitude",      :decimal,                :precision => 9, :scale => 6, :default => 0.0
    t.column "longitude",     :decimal,                :precision => 9, :scale => 6, :default => 0.0
  end

  create_table "track_accesses", :force => true do |t|
    t.column "name",        :string
    t.column "description", :string
  end

  create_table "track_akas", :force => true do |t|
    t.column "track_id", :integer
    t.column "name",     :string
  end

  create_table "track_grades", :force => true do |t|
    t.column "name",        :string
    t.column "description", :string
  end

  create_table "track_reports", :force => true do |t|
    t.column "track_id",    :integer
    t.column "user_id",     :integer
    t.column "status",      :string,   :default => "Green"
    t.column "description", :string
    t.column "date",        :datetime
  end

  create_table "tracks", :force => true do |t|
    t.column "name",            :string,   :limit => 80,                               :default => "",  :null => false
    t.column "area_id",         :integer
    t.column "access_note",     :string
    t.column "desc_brief",      :string
    t.column "desc_full",       :string
    t.column "desc_where",      :string
    t.column "desc_note",       :string
    t.column "alt_gain",        :integer,                                              :default => 0
    t.column "alt_loss",        :integer,                                              :default => 0
    t.column "alt_begin",       :integer,                                              :default => 0
    t.column "alt_end",         :integer,                                              :default => 0
    t.column "alt_note",        :string
    t.column "grade_note",      :string
    t.column "date",            :datetime
    t.column "author",          :integer
    t.column "zoom",            :integer,                                              :default => 0,   :null => false
    t.column "length",          :decimal,                :precision => 5, :scale => 2, :default => 0.0
    t.column "latitude",        :decimal,                :precision => 9, :scale => 6, :default => 0.0
    t.column "longitude",       :decimal,                :precision => 9, :scale => 6, :default => 0.0
    t.column "track_grade_id",  :integer
    t.column "track_access_id", :integer
    t.column "condition_id",    :integer
  end

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "privilege",                 :string,   :limit => 20, :default => "editor"
  end

end
