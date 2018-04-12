# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class DatabaseSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :project
  has_many :tables
end
