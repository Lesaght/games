import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("ИГРОВОЙ ЦЕНТР")
                    .font(.system(size: 36, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.top, 40)

                VStack(spacing: 20) {
                    NavigationLink(destination: SnakeView()) {
                        MenuButtonView(title: "Змейка", icon: "scribble.variable", color: .green)
                    }
                    NavigationLink(destination: MinesweeperView()) {
                        MenuButtonView(title: "Сапёр", icon: "square.grid.3x3.fill", color: .red)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
        }
    }
}

struct MenuButtonView: View {
    let title: String; let icon: String; let color: Color
    var body: some View {
        HStack {
            Image(systemName: icon).font(.title).foregroundColor(color).frame(width: 40)
            Text(title).font(.title2.weight(.bold)).foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.white.opacity(0.5))
        }
        .padding().background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 32)
    }
}
