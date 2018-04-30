class BaseCommand
  attr_reader :result, :status

  def self.call(*args)
    new(*args).call
  end

  def call
    @result = nil
    run
    self
  end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  private

  def initialize(*_)
    not_implemented
  end

  def run
    not_implemented
  end
end
