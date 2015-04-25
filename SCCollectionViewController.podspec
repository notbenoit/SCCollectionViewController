Pod::Spec.new do |s|
  s.name = 'SCCollectionViewController'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A controller presenting a collection view with out of the box effects, like parallax, growing header, and a fading navigation bar."
  s.homepage = 'https://github.com/notbenoit/SCCollectionViewController'
  s.social_media_url = 'http://twitter.com/notbenoit'
  s.authors = { 'Benoit Layer' => 'benoit.layer@gmail.com' }
  s.source = { :git => 'https://github.com/notbenoit/SCCollectionViewController.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'

  s.requires_arc = true
end
