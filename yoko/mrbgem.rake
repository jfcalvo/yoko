MRuby::Gem::Specification.new 'yoko' do |spec|
  spec.license = 'BSD'
  spec.author  = 'José Francisco Calvo <josefranciscocalvo@gmail.com>'
  spec.version = '0.0.1'
  spec.summary = 'A mruby gem to develop games'

  spec.rbfiles << Dir.glob("#{dir}/mrblib/**/*.rb")
end
