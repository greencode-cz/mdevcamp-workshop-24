import SwiftUI
import MAUL
import MapKit

struct SearchFieldScreen: View {

  let restaurants = ["Restaurant1", "Restaurant2", "Restaurant3"]
  let shops = ["Shop1", "Shop2"]
  let chargers = ["Charger1", "Charger2"]

  @State var searchText = ""
  @State var restaurantSelected = false
  @State var chargerSelected = false
  @State var shopSelected = false

  var searchResults: [String] {
    var filtered: [String] = []
    if restaurantSelected {
      if searchText.isEmpty {
        filtered.append(contentsOf: restaurants)
      } else {
        filtered.append(contentsOf: restaurants.filter { $0.contains(searchText) })
      }
    }
    if shopSelected {
      if searchText.isEmpty {
        filtered.append(contentsOf: shops)
      } else {
        filtered.append(contentsOf: shops.filter { $0.contains(searchText) })
      }
    }
    if chargerSelected {
      if searchText.isEmpty {
        filtered.append(contentsOf: chargers)
      } else {
        filtered.append(contentsOf: chargers.filter { $0.contains(searchText) })
      }
    }
    return filtered
  }

  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.334_900,
                                   longitude: -122.009_020),
    latitudinalMeters: 750,
    longitudinalMeters: 750
  )

  var body: some View {
    Map(coordinateRegion: $region).frame(maxWidth: .infinity, maxHeight: .infinity)
      .searchable(text: $searchText, placement: .automatic, prompt: "Search") {
        HStack {
          Toggle(isOn: $restaurantSelected) {
            Text("Restaurants")
          }
          .toggleStyle(MAULChipToggleStyle(style: .shadow))
          
          Toggle(isOn: $shopSelected) {
            Text("Shops")
          }
          .toggleStyle(MAULChipToggleStyle(style: .shadow))

          Toggle(isOn: $chargerSelected) {
            Text("Chargers")
          }
          .toggleStyle(MAULChipToggleStyle(style: .shadow))
        }
        ForEach(searchResults, id: \.self) { name in
          Text(name)
        }
      }
      .navigationTitle("Search")
#if os(iOS)
    // Caused problems on iPhone when applied .large or .automatic. - Use .inline
      .navigationBarTitleDisplayMode(.inline)
#endif
  }
}

struct SearchFieldScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchFieldScreen()
    }
    .setupMAULForPreviews()
  }
}
