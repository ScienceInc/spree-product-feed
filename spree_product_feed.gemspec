# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_product_feed'
  s.version     = '1.0.5'
  s.summary     = 'Spree extension that provides an RSS feed for products'
  s.description = 'A Spree extension that provides an RSS feed for products, with Google Shopper extensions'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'Joshua Nussbaum'
  s.email             = 'joshnuss@gmail.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.1.0'
  s.add_development_dependency 'rspec-rails'
end

