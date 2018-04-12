# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :type
  belongs_to :table
  has_many :row_values
end
