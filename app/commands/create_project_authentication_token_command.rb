# Authentication implementation mostly copied and slightly adapted from
# https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/
# Big thanks!


class CreateProjectAuthenticationTokenCommand < BaseCommand
  private

  attr_reader :project

  def initialize(project)
    @project = project
  end

  def run
    @result = JwtService.encode(content)
  end

  def content
    {
      project_id: project.id,
      exp: 1.year.from_now.to_i
    }
  end
end
