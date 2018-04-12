# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class Column < ApplicationRecord
  belongs_to :table
  has_many :row_values, dependent: :destroy

  after_commit :trigger_column_creation, on: :create
  before_destroy :trigger_column_destruction

 private

  def trigger_column_creation
    CreateColumnJob.perform_later(self)
  end

  def trigger_column_destruction
    DestroyColumnJob.perform_later(table.database.database_identifier,
                                   table.name,
                                   self.name)
  end
end
