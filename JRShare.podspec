#
# Be sure to run `pod lib lint JRShare.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'JRShare'
s.version          = '0.0.1'
s.summary          = 'A short description of JRShare.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/Cone1989/JRShare'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'liqiang' => 'liqiang38@58.com' }
s.source           = { :git => 'https://github.com/Cone1989/JRShare.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.public_header_files 'JRShare/Classes/IQShare.h'
#s.source_files = 'JRShare/Classes/*.{h,m}'

s.subspec 'Share' do |share|
    share.source_files = 'JRShare/Classes/share/**/*'
end

s.subspec 'QQ' do |qq|
    qq.source_files = 'JRShare/Classes/qq/**/*'
    qq.dependency   = 'JRShare/Share'
    qq.vendored_frameworks = 'JRShare/Classes/qq/sdk/*.{framework}'
end

s.subspec 'Wechat' do |wx|
    wx.source_files = 'JRShare/Classes/wechat/**/*'
    wx.dependency   = 'JRShare/Share'
    wx.vendored_libraries = 'JRShare/Classes/wechat/sdk/*.{a}'
end



s.frameworks    = "SystemConfiguration" , "CoreTelephony"
s.library       = "c++" , "z" , "sqlite3.0"

s.requires_arc  = true
s.xcconfig    = {
'OTHER_LDFLAGS' => '-ObjC',
}
end

