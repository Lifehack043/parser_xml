

desc 'Parse file and fill database'
task :parse_and_store_file, %i[file_to_parse config_file] do |_task_name, args|
  require_relative './system/boot'
  transaction_key = 'transactions.parse_xml_file'
  Parser[transaction_key].(args)
end

desc 'setup base'
task :setup_base do
  require_relative './system/boot'
  ActiveRecord::Schema.define do
    create_table :purchases do |t|
      t.string :guid
      t.string :name
      t.datetime :create_date_time
      t.belongs_to :customer
      t.timestamps
    end

    create_table :customers do |t|
      t.string :full_name, null: false
      t.bigint :reg_num, null: false
      t.string :postal_adress, null: false
      t.string :legal_adress, null: false
      t.bigint :inn, null: false
      t.bigint :kpp, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.timestamps
    end

    create_table :lots do |t|
      t.uuid :guid
      t.integer :price
      t.string :delivery_place
      t.belongs_to :purchase
      t.timestamps
    end

    create_table :lot_items do |t|
      t.belongs_to :lot
      t.string :okpd_code
      t.string :okpd_name
      t.integer :okei_code
      t.string :okei_national_code
      t.float :qty
      t.timestamps
    end
  end
end
