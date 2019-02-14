Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "EinfachTableview"
s.summary = "Damit wird Tableview einfach sein ..."
s.requires_arc = true

s.version = "0.1"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Marwen Doukh" => "marwen.doukh@protonmail.com" }

s.homepage = "https://github.com/marwendoukh/EinfachTableview-iOS"

s.source = { :git => "https://github.com/marwendoukh/EinfachTableview-iOS.git",
:tag => "#{s.version}" }


s.framework = "UIKit"
s.dependency 'ReachabilitySwift'
s.dependency 'RealmSwift'

s.source_files = "EinfachTableview/EinfachTableview/Protocols/*.{swift}" , "EinfachTableview/EinfachTableview/Services/*.{swift}" , "EinfachTableview/EinfachTableview/Enums/*.{swift}" , "EinfachTableview/EinfachTableview/Repositories/*.{swift}" , "EinfachTableview/EinfachTableview/*.{swift}"



s.swift_version = "4.2"

end

