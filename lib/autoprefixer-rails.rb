# Ruby integration with Autoprefixer JS library, which parse CSS and adds
# only actual prefixed
module AutoprefixerRails
  autoload :Sprockets, 'autoprefixer-rails/sprockets'

  # Add prefixes to `css`. See `Processor#process` for options.
  def self.process(css, opts = { })
    params = { }
    params[:browsers] = opts.delete(:browsers) if opts.has_key?(:browsers)
    params[:cascade]  = opts.delete(:cascade)  if opts.has_key?(:cascade)
    params[:remove]   = opts.delete(:remove)   if opts.has_key?(:remove)
    processor(params).process(css, opts)
  end

  # Add Autoprefixer for Sprockets environment in `assets`.
  # You can specify `browsers` actual in your project.
  def self.install(assets, params = { }, opts = { })
    Sprockets.new( processor(params) ).install(assets, opts)
  end

  # Cache processor instances
  def self.processor(params = { })
    Processor.new(params)
  end
end

require(File.expand_path('autoprefixer-rails/result', File.dirname(__FILE__)))
require(File.expand_path('autoprefixer-rails/version', File.dirname(__FILE__)))
require(File.expand_path('autoprefixer-rails/processor', File.dirname(__FILE__)))

require(File.expand_path('autoprefixer-rails/railtie', File.dirname(__FILE__))) if defined?(Rails)
