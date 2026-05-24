import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 1. Космический фон (Глубокий сине-фиолетовый градиент)
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.05, blue: 0.25), // Темно-фиолетовый
                        Color(red: 0.05, green: 0.1, blue: 0.3),  // Темно-синий
                        Color(red: 0.02, green: 0.05, blue: 0.15) // Почти черный
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // 2. Туманности (Nebula эффект)
                Circle()
                    .fill(Color.purple.opacity(0.4))
                    .blur(radius: 90)
                    .frame(width: 350, height: 350)
                    .offset(x: 100, y: -200)

                Circle()
                    .fill(Color.cyan.opacity(0.3))
                    .blur(radius: 100)
                    .frame(width: 400, height: 400)
                    .offset(x: -150, y: 300)
                
                Circle()
                    .fill(Color.pink.opacity(0.2))
                    .blur(radius: 90)
                    .frame(width: 300, height: 300)
                    .offset(x: 150, y: 150)

                // 3. Неоновая сетка (Grid)
                NeonGridView()

                // 4. Падающие звезды / Метеориты
                MeteorsView()

                // 5. Контент меню
                VStack(spacing: 40) {
                    // Заголовок
                    VStack(spacing: 8) {
                        Text("ARCADE")
                            .font(.system(size: 54, weight: .heavy, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(red: 0.3, green: 0.9, blue: 1.0), .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .purple.opacity(0.6), radius: 15, x: 0, y: 0)

                        Text("Выбери игру")
                            .font(.title3.weight(.medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 80)

                    // Кнопки
                    VStack(spacing: 24) {
                        NavigationLink(destination: SnakeView()) {
                            NeonGameButton(
                                title: "Змейка",
                                subtitle: "Классическая аркада",
                                icon: "scribble.variable",
                                glowColor: Color(red: 0.2, green: 1.0, blue: 0.4) // Ядовито-зеленый
                            )
                        }

                        NavigationLink(destination: MinesweeperView()) {
                            NeonGameButton(
                                title: "Сапёр",
                                subtitle: "Разминируй поле",
                                icon: "square.grid.3x3.fill",
                                glowColor: Color(red: 1.0, green: 0.3, blue: 0.3) // Неоново-красный
                            )
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }
        }
        .tint(.white) // Белая кнопка "Назад" внутри игр
    }
}

// MARK: - Неоновая Кнопка
struct NeonGameButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let glowColor: Color

    var body: some View {
        HStack(spacing: 20) {
            // Иконка
            ZStack {
                Circle()
                    .stroke(glowColor.opacity(0.8), lineWidth: 2)
                    .background(Circle().fill(glowColor.opacity(0.15)))
                    .frame(width: 64, height: 64)
                    .shadow(color: glowColor.opacity(0.8), radius: 10, x: 0, y: 0)

                Image(systemName: icon)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(glowColor)
            }

            // Текст
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2.weight(.bold))
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.white.opacity(0.6))
            }

            Spacer()

            // Стрелочка
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(16)
        // Эффект матового стекла (Glassmorphism)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
        // Неоновая рамка вокруг кнопки
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(glowColor.opacity(0.6), lineWidth: 2)
                .shadow(color: glowColor.opacity(0.4), radius: 8, x: 0, y: 0)
        )
    }
}

// MARK: - Компонент: Сетка
struct NeonGridView: View {
    var body: some View {
        GeometryReader { proxy in
            Path { path in
                let spacing: CGFloat = 40
                let width = proxy.size.width
                let height = proxy.size.height
                
                // Вертикальные линии
                for x in stride(from: 0, through: width, by: spacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                }
                // Горизонтальные линии
                for y in stride(from: 0, through: height, by: spacing) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
            }
            .stroke(Color.white.opacity(0.05), lineWidth: 1)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Компонент: Метеориты (Падающие звезды)
struct MeteorsView: View {
    var body: some View {
        ZStack {
            Meteor().offset(x: -100, y: -250)
            Meteor().offset(x: 100, y: -350)
            Meteor().offset(x: -50, y: 200)
            Meteor().offset(x: 180, y: 50)
            
            // Мелкие звезды
            Circle().fill(.white).frame(width: 2, height: 2).offset(x: 120, y: -150)
            Circle().fill(.white.opacity(0.5)).frame(width: 3, height: 3).offset(x: -80, y: -50)
            Circle().fill(.white).frame(width: 1.5, height: 1.5).offset(x: 50, y: 250)
            Circle().fill(.white.opacity(0.7)).frame(width: 2, height: 2).offset(x: -150, y: 100)
        }
    }
}

struct Meteor: View {
    var body: some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [.white.opacity(0.8), .clear],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
            )
            .frame(width: 2, height: 60)
            .rotationEffect(.degrees(45))
    }
}

#Preview {
    MainMenuView()
        .preferredColorScheme(.dark)
}
