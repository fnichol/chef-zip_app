if defined?(ChefSpec)
  def install_zip_app_package(app)
    ChefSpec::Matchers::ResourceMatcher.new(:zip_app_package, :install, app)
  end
end
