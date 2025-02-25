import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0 // ✅ Track selected tab

    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            // ✅ Connect `selectedTab` to `TabView`
            TabView(selection: $selectedTab) {
                HomePageView()
                    .tag(0) // ✅ Assign tags for tracking
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                ActivitiesPageView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Activities")
                    }

                ProfilePageView()
                    .tag(2)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
            }

            // ✅ Custom Floating Tab Bar
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack {
                        Spacer()
                        TabBarView(selectedTab: $selectedTab) // ✅ Pass binding to sync tabs
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.bottom, -12)
            }
        }
    }
}

// ✅ Custom Floating TabBar
struct TabBarView: View {
    @Binding var selectedTab: Int // ✅ Bind selected tab to update it

    var body: some View {
        HStack {
            Spacer()
            TabBarButton(icon: "house.fill", tabIndex: 0, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: "bell.fill", tabIndex: 1, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: "person.crop.circle.fill", tabIndex: 2, selectedTab: $selectedTab)
            Spacer()
        }
        .frame(height: 60)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 30)
    }
}

// ✅ Custom Tab Bar Button
struct TabBarButton: View {
    let icon: String
    let tabIndex: Int
    @Binding var selectedTab: Int // ✅ Bind state to update `TabView`

    var body: some View {
        Button(action: {
            selectedTab = tabIndex // ✅ Switch tab when clicked
        }) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(selectedTab == tabIndex ? .white : Color(white: 0.7)) // ✅ Highlight active tab
        }
    }
}
