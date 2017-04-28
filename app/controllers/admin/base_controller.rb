class Admin::BaseController < ApplicationController
	http_basic_authenticate_with username: ENV['AUTHENTICATION_USERNAME'], password: ENV['AUTHENTICATION_PASSWORD']
end