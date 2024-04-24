import SwiftUI
import MAUL

struct HomeView: View {
  private let radius: CGFloat = 4
  @State var vehicle = false
  @State var battery = false
  @State var temperature = false
  @State var cardSelected = false

  @State private var imageSize: CGSize = CGSize()

  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
          Image("car")
            .resizable()
            .scaledToFill()
        } else {
          Image("car-full")
            .resizable()
            .scaledToFill()
        }

        Group {
          // GroupBox has content and can be applied custom style, usage as card
          GroupBox {
            Toggle(isOn: $vehicle) {
              Text("Vehicle")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
            .toggleStyle(.maul())

            Spacer.MAUL.S()

            HStack {
              Text("Doors closed")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Text.primary)

              Spacer()

              Text("Unlocked")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Semantic.warning)
            }
          }
          .groupBoxStyle(.maulCard())

          GroupBox {
            Toggle(isOn: $battery) {
              Text("Battery range")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
            .toggleStyle(.maul())

            HStack {
              Text("30 km")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Semantic.warning)

              Spacer()

              Text("Charging")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Semantic.warning)
            }
          }
          .groupBoxStyle(.maulCard())

          GroupBox {
            Toggle(isOn: $temperature) {
              Text("Target temperature")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
            .toggleStyle(.maul())

            HStack {
              Text("22 ºC")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Text.primary)

              Spacer()

              Text("Climate")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
          }
          .groupBoxStyle(.maulCard())

          GroupBox {
            HStack {
              Text("Next plan")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)

              Spacer()
            }
            HStack {
              Text("Monday morning")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Text.primary)

              Spacer()

              Text("Mondey 8:00")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
          }
          .groupBoxStyle(.maulCard())

          // Button full layout is for full width in superview where the button is contained
          // Button has applied horizontal padding 16, so width is width of superview minus padding on left and right
          Button("Edit Order") {

          }
          .buttonStyle(.maulTertiary(layout: .full))

        }.padding(.horizontal, 16) // Group stands for apply padding to all inner views
      }

      // Bottom bar as VStack instead of toolbar
      //https://developer.apple.com/design/human-interface-guidelines/ios/bars/toolbars/
      // Toolbars and tab bars don’t appear together in the same view.
      VStack(spacing: 0) {
        ProgressView(value: 30, total: 100).progressViewStyle(.maulLinear)
        HStack(spacing: 0) {
          Text("0:01 h")
            .maulFontStyle(.h4)

          Spacer()

          Text("20%")
            .maulFontStyle(.h4)
            .foregroundColor(Color.MAUL.Brand.primary)

          Spacer()

          Text("20 km")
            .maulFontStyle(.h4)
        }
        .padding(.horizontal, 16)
        .frame(maxHeight: .infinity)
        .foregroundColor(Color.MAUL.Text.secondary)
      }
      .frame(height: 56)
    }
    .navigationTitle("Phantom")
    .navigationBarTitleDisplayMode(.large)
    .background(Color.MAUL.Background.primary)
  }

}

struct HomeScreen: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Image(systemName: "car.fill")
          Text("Home")
        }

      HomeView()
        .tabItem {
          Image(systemName: "mappin")
          Text("Maps")
        }

      HomeView()
        .tabItem {
          Image(systemName: "heart.fill")
          Text("Inspect")
        }

      HomeView()
        .tabItem {
          Image(systemName: "gearshape.fill")
          Text("Settings")
        }
    }
    .withMAULStyle
    .toolbar {
      ToolbarItem {
        Image(systemName: "bell.badge.fill")
      }
    }
  }
}
