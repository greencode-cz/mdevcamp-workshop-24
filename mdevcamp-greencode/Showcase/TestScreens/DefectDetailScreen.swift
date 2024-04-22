import SwiftUI
import MAUL

struct ChargerConnectorRow: View {
  var data: ChargerConnector

  var body: some View {
    HStack {
      VStack {
        Text(data.title)
        Text(data.description)
      }
      Spacer()
      Text(data.state.rawValue)
    }
  }
}

enum ChargerConnectorState: String {
  case available = "available"
  case inUse = "in use"
}

struct ChargerConnector: Hashable, Identifiable {
  var id = UUID()
  var title: String
  var description: String
  var state: ChargerConnectorState
}

struct DefectDetailScreen: View {
  private var chargerConnectors = [
    ChargerConnector(title: "22 kW", description: "33333", state: ChargerConnectorState.available),
    ChargerConnector(title: "22 kW", description: "33333", state: ChargerConnectorState.available),
    ChargerConnector(title: "22 kW", description: "33333", state: ChargerConnectorState.inUse)
  ]

  var body: some View {
    List {
      Section(header: MAULSectionHeader(title: "Type 2 (3/4 available)")) {
        VStack {
          ForEach(chargerConnectors) { item in
            NavigationLink(destination: Text("Detail")) {
              ChargerConnectorRow(data: item)
            }

            Divider()
              .modifier(MAULStyle())
          }
        }
      }
    }
#if os(iOS)
    .navigationBarTitle("PRE Charger connectors")
#endif
  }
}
