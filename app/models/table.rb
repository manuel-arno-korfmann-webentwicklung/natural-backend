# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class Table < ApplicationRecord
  has_many :columns, dependent: :destroy
  has_many :rows, dependent: :destroy
  belongs_to :database

  after_commit :trigger_table_creation, on: :create
  before_destroy :trigger_table_destruction

 private

  def trigger_table_creation
    CreateTableJob.perform_later(self)
  end

  def trigger_table_destruction
    DestroyTableJob.perform_later(database.database_identifier, self.name)
  end
end
