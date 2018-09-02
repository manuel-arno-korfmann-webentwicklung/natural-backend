class EmberController < ApplicationController
    skip_before_action :authenticate_user
    def serve
        render html: 'public/index.html', layout: false
    end
end
