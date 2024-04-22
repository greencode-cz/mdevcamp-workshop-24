import SwiftUI
import MapKit
import MAUL
import BottomSheet

#if os(iOS)
struct StandardSheetScreen: View {

  @State private var mapRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
  )
  @State private var sheetPosition: BottomSheetPosition = .bottom
  @State private var stop1 = "Prague"
  @State private var stop2 = "Plzen"
  @State private var stop3 = "Munich"
  @State private var addStop = ""

  var body: some View {
    Map(coordinateRegion: $mapRegion)
      .bottomSheet(
        bottomSheetPosition: $sheetPosition,
        options: [
          .shadow(),
          .background(AnyView(Color.MAUL.Background.primary)),
          .appleScrollBehavior
        ],
        title: "Edit route",
        content: {
          VStack(spacing: .MAUL.S) {
            HStack {
              Image.MAUL.shapeCircleFill

              MAULTextField(
                text: $stop1,
                titleConfiguration: .init(title: "Stop", isFloating: false)
              )
            }

            HStack {
              Image.MAUL.shapeCircleFill

              MAULTextField(
                text: $stop2,
                titleConfiguration: .init(title: "Stop", isFloating: false)
              )
            }

            HStack {
              Image.MAUL.shapeCircleFill

              MAULTextField(
                text: $stop3,
                titleConfiguration: .init(title: "Stop", isFloating: false)                            )
            }

            if sheetPosition == .top {
              HStack {
                Image.MAUL.shapeCircleFill

                MAULTextField(
                  text: $stop2,
                  titleConfiguration: .init(title: "Stop", isFloating: false)
                )
              }

              HStack {
                Image.MAUL.shapeCircleFill

                MAULTextField(
                  text: $stop3,
                  titleConfiguration: .init(title: "Stop", isFloating: false)
                )
              }

              HStack {
                Image.MAUL.shapeCircleFill

                MAULTextField(
                  text: $stop3,
                  titleConfiguration: .init(title: "Stop", isFloating: false)
                )
              }
            }

            HStack {
              Image.MAUL.circlePlus

              MAULTextField(
                text: $addStop,
                titleConfiguration: .init(title: "Add stop", isFloating: false)
              )
            }

            Button("Button") {
              sheetPosition = .hidden
            }
            .buttonStyle(.maulPrimary(layout: .standard))
          }
          .padding(.horizontal, .MAUL.L)
        }
      )
      .navigationTitle("Route to Milan")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button {
          sheetPosition = .bottom
        } label: {
          Image.MAUL.plusFill
        }
        .tint(Color.MAUL.Text.primary)
      }
  }
}

struct ModalSheetSmallScreen: View {

  enum BottomSheetPositionAbsolute: CGFloat, CaseIterable {
    case top = 300.0
    case middle = 50.0
    case hidden = 0.0
  }

  @State private var sheetPosition: BottomSheetPositionAbsolute = .hidden

  var body: some View {
    VStack(spacing: 20) {
      Button("Show Bottom Sheet") {
        sheetPosition = .top
      }
    }
    .bottomSheet(bottomSheetPosition: $sheetPosition,
                 options: [
                  .shadow(),
                  .background(
                    AnyView(Color.MAUL.Background.primary)
                  ),
                  .backgroundBlur(effect: .dark),
                  .absolutePositionValue,
                  .noDragIndicator,
                  .tapToDissmiss,
                  .notResizeable
                 ],
                 title: "Action list") {
      List {
        ForEach(0..<4) {
          Text("\($0)")
        }
      }
      .onTapGesture {
        sheetPosition = .hidden
      }
      .listStyle(PlainListStyle())
    }
                 .navigationTitle("Route to Milan")
                 .navigationBarTitleDisplayMode(.inline)
  }
}

struct ModalSheetLargeScreen: View {
  @State private var sheetPosition: BottomSheetPosition = .hidden

  var body: some View {
    VStack(spacing: 20) {
      Button("Show Bottom Sheet") {
        sheetPosition = .top
      }
    }
    .bottomSheet(bottomSheetPosition: $sheetPosition,
                 options: [
                  .shadow(),
                  .background(
                    AnyView(Color.MAUL.Background.primary)
                  ),
                  .backgroundBlur(effect: .dark),
                  .noDragIndicator,
                  .tapToDissmiss,
                  .notResizeable
                 ],
                 title: "Action list") {
      List {
        ForEach(0..<20) {
          Text("\($0)")
        }
      }
      .onTapGesture {
        sheetPosition = .hidden
      }
      .listStyle(PlainListStyle())
    }
                 .navigationTitle("Route to Milan")
                 .navigationBarTitleDisplayMode(.inline)
  }
}

struct SheetNavigationScreen: View {
  var body: some View {
    List {
      NavigationLink("Small Modal bottom sheet") {
        ModalSheetSmallScreen()
      }
      NavigationLink("Large Modal bottom sheet") {
        ModalSheetLargeScreen()
      }
      NavigationLink("Standard bottom sheet") {
        StandardSheetScreen()
      }
      NavigationLink("Scrollable content height sheet - full height content") {
        ContentHeightSheetScreen(rows: 50)
          .navigationBarTitleDisplayMode(.inline)
      }
      NavigationLink("Scrollable content height  sheet") {
        ContentHeightSheetScreen(rows: 10)
          .navigationBarTitleDisplayMode(.inline)
      }
    }
    .navigationTitle("Sheets")
    .listStyle(.plain)
  }
}

struct ContentHeightSheetScreen: View {

  @State var rows: Int

  var body: some View {
    TabView {
      GeometryReader { sheetGeometry in
        Text("This is below all that is, all that ever was, and all that ever will be. See you in another life, brother.")
          .padding()
          .scrollableBottomSheetView(
            allowFullSize: true,
            backgroundColor: .MAUL.Background.secondary
          ) {
            VStack(spacing: .MAUL.S) {

              ForEach(0..<rows, id: \.self) { index in
                Text("Additional nr. \(index)")
              }

            }
          }
      }
      .tabItem {
        Label("Sheet view", systemImage: "heart.fill")
      }

      Text("Something else")
        .tabItem {
          Label("Something else", systemImage: "person")
        }
    }
  }
}

struct SheetTestScreen_Previews: PreviewProvider {
  static var previews: some View {
    ModalSheetSmallScreen()
      .setupMAULForPreviews()

    ModalSheetLargeScreen()
      .setupMAULForPreviews()

    StandardSheetScreen()
      .setupMAULForPreviews()

    ContentHeightSheetScreen(rows: 10)
      .setupMAULForPreviews()

    ContentHeightSheetScreen(rows: 60)
      .setupMAULForPreviews()
  }
}
#endif
