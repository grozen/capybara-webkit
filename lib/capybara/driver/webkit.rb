require "capybara"
require "capybara/driver/webkit/node"
require "capybara/driver/webkit/browser"

class Capybara::Driver::Webkit
  class WebkitError < StandardError
  end

  attr_reader :browser

  def initialize(app, options={})
    @app = app
    @options = options
    @rack_server = Capybara::Server.new(@app)
    @rack_server.boot if Capybara.run_server
    @browser = Browser.new
  end

  def current_url
    raise NotImplementedError
  end

  def visit(path)
    browser.visit(url(path))
  end

  def find(query)
    browser.find(query).map { |native| Node.new(self, native) }
  end

  def source
    raise NotImplementedError
  end

  def body
    raise NotImplementedError
  end

  def execute_script(script)
    raise Capybara::NotSupportedByDriverError
  end

  def evaluate_script(script)
    raise Capybara::NotSupportedByDriverError
  end

  def response_headers
    raise Capybara::NotSupportedByDriverError
  end

  def status_code
    raise Capybara::NotSupportedByDriverError
  end

  def within_frame(frame_id)
    raise Capybara::NotSupportedByDriverError
  end

  def within_window(handle)
    raise Capybara::NotSupportedByDriverError
  end

  def wait?
    false
  end

  def wait_until(*args)
  end

  def reset!
    browser.reset!
  end

  def has_shortcircuit_timeout?
    false
  end

  private

  def url(path)
    @rack_server.url(path)
  end
end
