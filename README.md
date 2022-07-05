# Rx_MovieDB
[![Build Status](https://app.travis-ci.com/wliamgho/Rx_MovieDB.svg?token=pCriY64sTCpk2oMg2rev&branch=develop)](https://app.travis-ci.com/wliamgho/Rx_MovieDB)
[![codecov](https://codecov.io/gh/wliamgho/Rx_MovieDB/branch/develop/graph/badge.svg?token=bBBnmEsPQE)](https://codecov.io/gh/wliamgho/Rx_MovieDB)

Implementation The Movie DB using RxSwift.

## Dependency Injection
Dependency Injection a technique whereby one subject supplies the dependencies of another object, So that makes a class independent of its dependencies.

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

## TODO
 - [ ] Show Movie List Layout (Upcoming, Now Playing, Popular)
 - [ ] Show Movie Detail
 - [ ] Unit Test & Snapshot UI
 - [X] Dark Mode
 - [X] Create Dependency Injection
 - [ ] Modularity
 - [X] Navigation Flow
 - [ ] Fastlane
 - [ ] [Localization using google sheets](https://github.com/vivek-jl/LocalizationDemo) or [Next](https://github.com/aunnnn/SwiftyLocalization)
 - [ ] CI & CD Bitrise
 - [ ] Code Coverage (CodeCov) or [Sonarqube](https://medium.com/@pranay.urkude/sonarqube-integration-with-ios-b76df8405014)
 - [ ] [State machine](https://github.com/ReactKit/SwiftState)
 - [ ] [Submodules For Core, Product, Utils, Helper (Advance)](https://www.youtube.com/watch?v=y7w9oz2zcEU&t=988s)

## Optional
 - [ ] Using Texture
