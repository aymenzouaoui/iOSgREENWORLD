import SwiftUI
struct MainTabbedView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0


    @State private var items: [WasteType] = []  // Provide an array of WasteType
   // @State private var typeItem: [TypeItem] = []
    @ObservedObject private var viewModel = TypeViewModel() // Use TypeViewModel
    // Use WasteViewModel instead of TypeViewModel

    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedSideMenuTab) {
                    HomeView(presentSideMenu: $presentSideMenu)
                        .tag(0)
                    DechetsList(presentSideMenu: $presentSideMenu, items: $viewModel.items)
                        .onAppear()
                        {
                            viewModel.getAllTypes()
                        }
                        .tag(3)

                    EventListView(presentSideMenu: $presentSideMenu)
                        .tag(4)

                    Product(presentSideMenu: $presentSideMenu)
                        .tag(2)

                    Profile(presentSideMenu: $presentSideMenu)
                        .tag(6)
                }

                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
