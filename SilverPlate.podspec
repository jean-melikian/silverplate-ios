Pod::Spec.new do |s|
s.name      = "SilverPlate"
s.version   = "0.4.3"
s.summary   = "Just another framework serving everything you need on a silver plate"
s.homepage  = "https://github.com/SilverPlate-Framework/silverplate-ios"
s.license   = { :type => "BSD", :file => "LICENSE" }
s.authors   = { "Jean-Christophe Melikian" => "jean.melikian@gmail.com", "Antoine Pelletier" => "pelletier.antoinepro@gmail.com" }
s.source    = { :git => "https://github.com/SilverPlate-Framework/silverplate-ios.git",  :tag => "v#{s.version}" }
s.source_files  = 'SilverPlate/*.{swift,h}'
s.ios.deployment_target = '8.0'
s.requires_arc  = true
end
