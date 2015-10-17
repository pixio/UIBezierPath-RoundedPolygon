Pod::Spec.new do |s|
  s.name             = "UIBezierPath-RoundedPolygon"
  s.version          = "0.1.1"
  s.summary          = "UIBezierPath-RoundedPolygon gives you rounded convex polygons."
  s.description      = <<-DESC
                       You can make all sorts of rounded-corner paths.  Try making a rounded triangle.
                       DESC
  s.homepage         = "https://github.com/pixio/UIBezierPath-RoundedPolygon"
  s.license          = 'MIT'
  s.author           = { "Daniel Blakemore" => "DanBlakemore@gmail.com" }
  s.source = {
   :git => "https://github.com/pixio/UIBezierPath-RoundedPolygon.git",
   :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
