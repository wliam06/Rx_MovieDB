# Rx_MovieDB
[![Build Status](https://app.bitrise.io/app/062c202c43a0e102/status.svg?token=8ljnE41Y_jZX5RG-J5QCug&branch=develop)](https://app.bitrise.io/app/062c202c43a0e102)
[![codecov](https://codecov.io/gh/wliamgho/Rx_MovieDB/branch/develop/graph/badge.svg?token=bBBnmEsPQE)](https://codecov.io/gh/wliamgho/Rx_MovieDB)

Create TheMovieDB with RxSwift

## Resolver
In this repo, Resolver is used to get dependencies from a certain store and enables us to use seamless dependency injection. 

 - Container
 Stores and register the configuration

 - Resolver
 Resolve the implementation and using the configuration of the Container.

 - ResolverFactory
 Instances Resolver
