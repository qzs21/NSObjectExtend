Pod::Spec.new do |s|
  s.name     = 'NSObjectExtend'
  s.version  = '1.0'
  s.license  = { :type => 'MIT' }
  s.summary  = 'NS系列库扩充方法.'
  s.homepage = 'http://blog.isteven.cn'
  s.authors  = { 'Steven' => 'qzs21@qq.com' }
  s.source   = {
    :git => 'https://github.com/qzs21/NSObjectExtend.git',
    :tag => s.version
  }
  s.frameworks = 'UIKit'
  s.resources = 'Resource/*.lproj'
  s.libraries = 'z'
  s.source_files = 'NSObjectExtend.h'
  s.requires_arc = true
  s.ios.deployment_target = '6.0'

  s.subspec 'NSObjectExtend' do |spec|
    spec.requires_arc = true
    spec.source_files = [
      'Classes/*.{h,m}',
    ]
  end

end