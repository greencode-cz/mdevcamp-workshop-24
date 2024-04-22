import SwiftUI
import MAUL

extension Shape {
  func elevation(_ elevation: ElevationSize) -> some View {
    return modifier(Elevation(elevation: elevation, isContainer: false))
  }
}

// swiftlint:disable identifier_name
enum ElevationSize: String, CaseIterable, Equatable {
  case S
  case M
  case L
  case XL
}

struct Elevation: ViewModifier {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  var elevation: ElevationSize
  /// A parameter define if color will be applied for containers as s background color and for others as s foreground color
  var isContainer: Bool

  @ViewBuilder func body(content: Content) -> some View {
    content
      .modifier(ElevationColor(elevation: elevation, isContainer: isContainer))
      .modifier(ElevationShadow(elevation: elevation))
  }
}

struct ElevationShadow: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  var elevation: ElevationSize

  @ViewBuilder func body(content: Content) -> some View {
    let shadowColor = Color.black.opacity(0.18)
    let shadowColorXL = Color.black.opacity(0.1)
    switch elevation {
    case .S:
      content
        .shadow(color: shadowColor, radius: 1, x: 0, y: 0.2)
    case .M:
      colorScheme == .light
      ? content
        .shadow(color: shadowColor, radius: 3, x: 0, y: 1)
      : content
        .shadow(color: shadowColor, radius: 2, x: 0, y: 0.5)
    case .L:
      colorScheme == .light
      ? content
        .shadow(color: shadowColor, radius: 4, x: 0, y: 2)
      : content
        .shadow(color: shadowColor, radius: 4, x: 0, y: 1.5)
    case .XL:
      if colorScheme == .light {
        content
          .shadow(color: shadowColorXL, radius: 4, x: 0, y: -1)
          .shadow(color: shadowColor, radius: 6, x: 0, y: 5)
      } else {
        content
          .shadow(color: shadowColor, radius: 10, x: 0, y: 5)
      }
    }
  }
}

struct ElevationColor: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  var elevation: ElevationSize
  var isContainer: Bool = true

  private var color: Color {
    if colorScheme == .light {
      return Color.white
    } else {
      switch elevation {
      case .S:
        return Color.chrome850
      case .M:
        return Color.chrome800
      case .L:
        return Color.chrome750
      case .XL:
        return Color.chrome700
      }
    }
  }

  @ViewBuilder func body(content: Content) -> some View {
    if isContainer {
      content.background(color)
    } else {
      content.foregroundColor(color)
    }
  }
}

struct ElevationScreen: View {
  var body: some View {
    ScrollView {
      HStack {
        VStack {
          ForEach(ElevationSize.allCases, id: \.self) { size in
            HStack {
              // elevation need to be set before frame or other modifier that changes it to some View
              RoundedRectangle(cornerRadius: 4)
                .elevation(size)
                .frame(width: 100, height: 100, alignment: .leading)
                .overlay( Text(size.rawValue), alignment: .center)
            }.padding(50)
          }
        }.environment(\.colorScheme, .dark)
        VStack {
          ForEach(ElevationSize.allCases, id: \.self) { size in
            HStack {
              RoundedRectangle(cornerRadius: 4)
                .elevation(size)
                .frame(width: 100, height: 100, alignment: .leading)
                .overlay( Text(size.rawValue), alignment: .center)
            }.padding(50)
          }
        }.environment(\.colorScheme, .dark).background(Color.black)
      }.frame(maxWidth: .infinity)

      HStack {
        VStack {
          ForEach(ElevationSize.allCases, id: \.self) { size in
            HStack {
              RoundedRectangle(cornerRadius: 4)
                .elevation(size).frame(width: 100, height: 100, alignment: .leading)
                .foregroundColor(.MAUL.Background.primary)
                .overlay( Text(size.rawValue), alignment: .center)
            }.padding(50)
          }
        }.environment(\.colorScheme, .light)
        VStack {
          ForEach(ElevationSize.allCases, id: \.self) { size in
            HStack {
              RoundedRectangle(cornerRadius: 4)
                .elevation(size)
                .frame(width: 100, height: 100, alignment: .leading)
                .foregroundColor(.MAUL.Background.primary)
                .overlay( Text(size.rawValue), alignment: .center)
            }.padding(50)
          }
        }.environment(\.colorScheme, .light).background(Color.white)
      }.frame(maxWidth: .infinity)
    }
    .navigationTitle("Elevation")
  }
}

struct ElevationScreen_Previews: PreviewProvider {
  static var previews: some View {
    ElevationScreen()
      .setupMAULForPreviews()
  }
}
