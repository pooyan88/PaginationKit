#
#  Be sure to run `pod spec lint PaginationKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "PaginationKit"
  spec.version      = "1.0.0"
  spec.summary      = "A lightweight Swift paginator utility for async paginated data loading in SwiftUI and UIKit."

  spec.description  = <<-DESC
    PaginationKit is a simple utility to handle paginated data fetching with async/await.
    It works seamlessly with SwiftUI and UIKit, managing state, errors, and data flow for paginated APIs.
  DESC

  spec.homepage     = "https://github.com/pooyan88/PaginationKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Pooyan J" => "pooyanjavidi@gmail.com" }
  spec.social_media_url = "https://www.instagram.com/pooyanjavidi88"

  spec.platform     = :ios, "13.0"
  spec.swift_version = "5.7"

  spec.source       = { :git => "https://github.com/pooyan88/PaginationKit.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/PaginationKit/**/*.{swift}"

end
