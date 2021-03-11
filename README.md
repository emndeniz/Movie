# Movie app

Movie app is a sample app that fetches movie from api.themoviedb.org.

It is implemented based on VIPER architecture. For more information about VIPER please check the [infinium github page](https://github.com/infinum/iOS-VIPER-Xcode-Templates)

Application has 2 scenes MoviList and MovieDetail.
MovieList shows favorite movies from API and user can search fetched movies. Also, user can select favorite movies. 
MovieDetail scene shows detail about movies.

## Application Structure

Movie app has 4 basic structure. Scenes, Networking layer, Managers, Common utility files. 
Application implemented using Protocol Design Oriented approach with VIPER architecture.

###Scenes

Scenes includes VIPER scenes as name implies. Wireframes packages all VIPER flow in it. When View Controller initated, Wireframes also initated required Formatters, Presenters and Interactors. All modules have protocols as Protocol Oriented Design suggests.


### Networking Layer

Using networking layer application can fetch data from API. On top of the Networking we Have `ServiceProvider`. Using ServiceProvider we can call services like `MovieService`. We can have more services on future and all of them can be calling from ServiceProvider. 

When I design the Networking Layer, it is aimed to have simple usage on app level.

You can see an example API call in below; 

```
let provider = ServiceProvider<MovieService>()
provider.load(service: .movieDetail(id: movieId), decodeType: MovieDetailModel.self) { result in
            switch result {
                case .success(let response):
                    print("getMovieDetail success data received, response: \(response)")
                    completion(response)
                case .failure(let error):
                    print("getMovieDetail fail data received, error: \(error.localizedDescription)")
                    completion(nil)
                case .empty:
                    print("getMovieDetail No data")
                    completion(nil)
    }
 }
```

## Commons

Commons are containing utility functions which can be useful for all of the application.

## Managers 

Managers are containing applications complex processes can be called from anywhere such as CoreData request. 

