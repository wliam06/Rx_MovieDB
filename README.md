# Rx_MovieDB
[![Build Status](https://app.travis-ci.com/wliamgho/Rx_MovieDB.svg?token=pCriY64sTCpk2oMg2rev&branch=develop)](https://app.travis-ci.com/wliamgho/Rx_MovieDB)
[![codecov](https://codecov.io/gh/wliamgho/Rx_MovieDB/branch/develop/graph/badge.svg?token=bBBnmEsPQE)](https://codecov.io/gh/wliamgho/Rx_MovieDB)

Implementation The Movie DB using RxSwift.

## Architecture
### Modular
<p align = "center">
   <img src= "https://user-images.githubusercontent.com/25744906/184834232-11d403cf-105e-4d8e-ac37-3eae9a166503.jpg">
</p>

Modularity is a software design technique that emphasizes of separating the functionality of a program into independent, interchangeable modules that each contains everything necessary to execute only one aspect of the desired functionality.

### Cocoapods
We use Cocoapods as a dependency manager to split the app in isolated modules. The reason why we will using Cocoapods is the documentation and many developers are use this. To avoid the conflict branch and project, we can use [Xcodegen](https://github.com/yonaskolb/XcodeGen) to help generate our code structure and configuration.

## Dependency Injection
Dependency Injection a technique whereby one subject supplies the dependencies of another object, So that makes a class independent of it's dependencies.
I used Swift property-wrapper, keypath-based as dependency injection system. The keypaths ensure compile-time safety for all injectable services.
The property wrapper allows injecting dependencies and reduces code clutter on the implementation side. The static subscript used to make sure we don't end up with side effects and weird outcomes due to inconsistent dependency references.

### How to use:
```
// Strong References
   protocol A {}
   struct SampleA: A {}

   private struct SampleAProviderKey: InjectionKey {
      static var currentValue: A = SampleA()
   }

   // Register
   Extension InjectedValue {
      var injectedA: A {
         get { Self[SampleAProviderKey] }
         set { Self[SampleAProviderKey] = newValue }
      }
   }

##########################

// Weak References
   protocol B {}
   struct SampleB: B {}
   private struct SampleBProviderKey: InjectionWeakKey {
      static weak var currentValue: B?
   }

   // Register
   extension InjectedWeakValue {
      var injectedB: B? {
         get { Self[SampleBProviderKey] }
         set { Self[SampleBProviderKey] = newValue }
      }
   }

// Implementation
   struct Loader {
      @Injected(\.injectedA) var protocolA: A //  Strong references
      @InjectedWeak(\.injectedB) var protocolB // Optional value (weak references)
   }
```

### Build Time
![log_report](https://user-images.githubusercontent.com/25744906/185784925-597b6933-c614-4cc0-8787-0645e2d0678b.png)

> **Note**
> This build time generate using XLogParser and already clean the derived data.


## TODO
 - [X] Show Movie List Layout (Upcoming, Now Playing, Popular)
 - [X] Show Movie Detail
 - [ ] Unit Test & Snapshot UI
 - [X] Dark Mode
 - [X] Create Dependency Injection
 - [X] Modularity
 - [X] Navigation Flow
 - [ ] Fastlane
 - [ ] [Localization using google sheets](https://github.com/vivek-jl/LocalizationDemo) or [Next](https://github.com/aunnnn/SwiftyLocalization)
 - [ ] CI & CD Bitrise
 - [ ] Code Coverage (CodeCov) or [Sonarqube](https://medium.com/@pranay.urkude/sonarqube-integration-with-ios-b76df8405014)
 - [X] [State machine](https://github.com/ReactKit/SwiftState)
 - [ ] [Submodules For Core, Product, Utils, Helper (Advance)](https://www.youtube.com/watch?v=y7w9oz2zcEU&t=988s)

## Optional
 - [ ] Using Texture
