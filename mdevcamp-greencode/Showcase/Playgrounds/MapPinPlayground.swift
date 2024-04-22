import SwiftUI
import MAUL

extension MAULTimePinSide {
  var name: String {
    switch self {
    case .topLeading :
      return "Top-Left"
    case .topTrailing :
      return "Top-Right"
    case .bottomLeading :
      return "Bottom-Left"
    case .bottomTrailing :
      return "Bottom-Right"
    }
  }
  var description: String {
    switch self {
    case .topLeading :
      return ".topLeading"
    case .topTrailing :
      return ".topTrailing"
    case .bottomLeading :
      return ".bottomLeading"
    case .bottomTrailing :
      return ".bottomTrailing"
    }
  }
}

struct MapPinPlayground: View {
  enum PinType: String, Equatable, CaseIterable {
    case maulPin = "Standard Pin"
    case maulTimePin = "Time Pin"
    case maulRoutePin = "Route Pin"
  }

  enum RoutePinContent: String, Equatable, CaseIterable {
    case icon
    case letter
  }

  @State var pinType: PinType = .maulPin
  let defaultText = "10 min ☇☇☇"
  @State var text = ""
  @State var side: MAULTimePinSide = .topLeading
  @ObservedObject var model = MAULPinModel(image: Image.MAUL.mapMarkerFill, selected: false)
  @State var routePinType: RoutePinContent = .icon
  @State var routePinAlternative: Bool = false

  @ViewBuilder func buildComponent() -> some View {
    if pinType == .maulPin {
      MAULPin(model: model).onTapGesture {
        model.selected.toggle()
      }
    }

    if pinType == .maulTimePin {
      MAULTimePin(model: MAULTimePinModel(text: text.isEmpty ? defaultText : text, side: side))
    }

    if pinType == .maulRoutePin {
      if routePinType == .icon {
        MAULRoutePin(model: MAULRoutePinModel(image: Image.MAUL.boltFill, isAlternative: routePinAlternative))
      }
      if routePinType == .letter {
        MAULRoutePin(model: MAULRoutePinModel(letter: "A", isAlternative: routePinAlternative))
      }
    }
  }

  func builtText() -> String {
    var code = ""
    if pinType == .maulPin {
      code = """
            //set propery model as ObservedObject
            @ObservedObject var model = MAULPinModel(image: Image.MAUL.mapMarkerFill, selected: false)

            MAULPin(model: model).onTapGesture {
                model.selected.toggle()
            }
            """
    }

    if pinType == .maulTimePin {
      code = """
            MAULTimePin(model: MAULTimePinModel(text: \"\(text.isEmpty ? defaultText : text)\", side: \(side.description)))
            """
    }
    if pinType == .maulRoutePin {
      let modelCode = """
            MAULRouteTinModel(\(routePinType == .icon ? "image: Image.MAUL.boltFill" : "letter: \"A\""), isAlternative: \(routePinAlternative ? "true" : "false"))
            """
      code = """
            MAULRoutePin(model: \(modelCode))
            """
    }
    return code
  }

  var controls: some View {
    VStack(spacing: .MAUL.S) {
      HStack {
        Text("Type")
        Spacer()
        Picker("", selection: $pinType) {
          ForEach(PinType.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
      }
      if pinType == .maulPin {
        Toggle("Selected", isOn: $model.selected)
      }
      if pinType == .maulTimePin {
        TextField(defaultText, text: $text)
          .withMAULStyle
        HStack {
          Text("Side")
          Spacer()
          Picker("", selection: $side) {
            ForEach(MAULTimePinSide.allCases, id: \.self) {
              Text($0.name)
            }
          }
        }
      }
      if pinType == .maulRoutePin {
        HStack {
          Text("Content")
          Spacer()
          Picker("", selection: $routePinType) {
            ForEach(RoutePinContent.allCases, id: \.self) {
              Text($0.rawValue)
            }
          }
        }
        Toggle("Is alternative", isOn: $routePinAlternative)
      }
    }
    .toggleStyle(.maul())
  }

  var body: some View {
    PlaygroundScreen(code: builtText()) {
      controls
    } component: {
      buildComponent()
    } modalScreen: {
      MapPinScreen()
    }
    .navigationTitle("Pin")
  }
}

struct MapPinPlayground_Previews: PreviewProvider {
  static var previews: some View {
    MapPinPlayground()
      .setupMAULForPreviews()
  }
}
