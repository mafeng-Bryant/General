Pod::Spec.new do |s|
  s.name         = "MFPod"
  s.version      = "1.0.0"
  s.summary      = "pod库练习"
  s.description  = <<-DESC
                   A capable XCTestCase subclass
                   DESC
  s.homepage     = "https://github.com/Kobe-Bryant/MFPod/"
  s.license      = "MIT"
  s.author       = { "Win" => "email@address.com" }
  s.source       = { :git => "https://github.com/Kobe-Bryant/MFPod.git", :tag => "#{s.version}" }
  s.source_files  = "*", "*/**/*.{h,m}"
  s.requires_arc = true
end