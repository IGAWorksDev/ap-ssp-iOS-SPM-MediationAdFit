// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APSDKMediationAdFit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "APSDKMediationAdFit",
            targets: ["APSDKMediationAdFitWrapper"]),
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "AdFitSDK",
                 url: "https://github.com/adfit/adfit-spm.git",
                 from: "3.18.6"),
        
        .package(name: "AdPopcornSSPSDK",
                 url: "https://github.com/IGAWorksDev/ap-ssp-iOS-SPM.git",
                 from: "0.0.3")
        
    ],
    targets: [
        // AdFit mediation 모듈 본체 (추가 UI 로직이 없으면 이걸로 충분)
        .binaryTarget(name: "APSDKMediationAdFitBinary",
                      path: "xcframework/APSDKMediationAdFit.xcframework"),
        
        // Wrapper 타겟: 외부에서 사용하는 진짜 타겟은 얘!
        .target(
            name: "APSDKMediationAdFitWrapper",
            dependencies: ["APSDKMediationAdFitBinary",
                           .product(name: "AdPopcornSSPSDK", package: "AdPopcornSSPSDK"),
                           .product(name: "AdFitSDK", package: "AdFitSDK"),
                          ],
            path: "xcframework/APSDKMediationAdFitWrapper"
        ),
    ]
)
