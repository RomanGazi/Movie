
Movie App

A SwiftUI-based movie fetching app that fetches latest and searched movies using The Movie Database (TMDB) API. Supports infinite scrolling, autocomplete search, and clean MVVM architecture.

Features:
    1. Browse latest movies with nfinite scroll.

    2. Search movies using TMDB Search API.

    3. Autocomplete suggestions with debounce.
 
 Technical Highlights:

    1. SwiftUI + MVVM

    2. Async/Await based networking

    3. Generics-powered API service (NetworkService)
    
Dependencies:

    No external dependencies.
    
Development Environment:
    Xcode Version: 26.1.1
    Minimum iOS: 18.6
    
Supports:
    1. Running all iPhone with iOS 18.6 and more.
    2. Only supports portrait mode.
    3. iPad supports in split mode. But initially right side is empty. after clicking one movie it shows details. 
    4. Offline mode isn't supported.
    
Feature Scope:
    1. Can implement database so that user can go through the list when there is no internet.
    2. iPad UI support.
    3. Write Unit test and UI test.
    
