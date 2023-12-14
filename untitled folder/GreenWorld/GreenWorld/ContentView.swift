import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TypeViewModel()
    @State private var presentSideMenu = false

    @Binding var items: [WasteType]
    
    var body: some View {
        DechetsList(presentSideMenu: $presentSideMenu, items: $viewModel.items)
            .onAppear(){
                viewModel.getAllTypes()
            }
    }
}
