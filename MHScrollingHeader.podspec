Pod::Spec.new do |s|

  s.name         = "MHScrollingHeader"
  s.version      = "0.0.1"
  s.summary      = "An Easy Way to Intergate Scrolling Header"
  s.homepage     = "https://github.com/MickeyHub/MHScrollingHeader"
  s.license      = "MIT"
  s.author       = { "MickeySha" => "791331313@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/MickeyHub/MHScrollingHeader.git", :tag => s.version }
  s.source_files  = "MHScrollHeader/ScrollingHeader/*.{h,m}"
  s.requires_arc = true

end
