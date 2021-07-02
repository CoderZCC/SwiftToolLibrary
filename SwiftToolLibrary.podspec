Pod::Spec.new do |s|

  s.name         = "SwiftToolLibrary"
  s.version      = "1.1.8"
  s.summary      = "SwiftToolLibrary"

  s.description  = <<-DESC
                   SwiftToolLibrary is a speedly tool to develop iOS App.
                   DESC

  s.homepage     = "https://github.com/CoderZCC/SwiftToolLibrary"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "coderzcc" => "coderzcc@163.com" }
  s.social_media_url   = "https://github.com/CoderZCC"

  s.platform = :ios, "10.0"
  s.swift_versions = ["5.0"]

  s.ios.deployment_target = "10.0"

  s.source       = { :git => "https://github.com/CoderZCC/SwiftToolLibrary.git", :tag => s.version }
  s.source_files  = ["Sources/**/*.swift"]

  s.requires_arc = true
end
