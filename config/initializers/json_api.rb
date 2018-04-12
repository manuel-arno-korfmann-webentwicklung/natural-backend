# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

ActiveSupport.on_load(:action_controller) do
  require 'active_model_serializers/register_jsonapi_renderer'
end

ActiveModelSerializers.config.adapter = :json_api
