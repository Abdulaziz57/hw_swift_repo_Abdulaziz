import SwiftUI
 

struct ContentView: View {
    @State private var searchField: String = ""
    @State private var displayedRepos: [Repository] = []
    @ObservedObject var viewModel = ViewModel()
    

    var body: some View {
        return NavigationView {
            VStack {
                TextField("Search", text: binding)
                    .padding(.leading)
                    .padding(.top, 5)

                List(displayedRepos) { repository in
                    NavigationLink(
                        destination: WebView(request: URLRequest(url: URL(string: repository.htmlURL)!))
                            .navigationBarTitle(repository.name)) {
                        RepositoryRow(repository: repository)
                    }
                }
                .navigationBarTitle("Swift Repos", displayMode: .inline)

                Spacer()
            }
            .onAppear {
                Task {
                    await loadData()
                }
            }
        }
    }
    
    func loadData() async {
        let repos = await Parser().fetchRepositories()
            self.viewModel.repos = repos
            self.displayedRepos = repos
    }
    
    func displayRepos() {
        if searchField == "" {
            displayedRepos = viewModel.repos
        } else {
            displayedRepos = viewModel.fileteredRepos
        }
    }
    
    var binding: Binding<String> {
        Binding(
            get: { self.searchField },
            set: {
                self.searchField = $0
                self.viewModel.search(searchText: self.searchField)
                self.displayRepos()
            }
        )
    }
    
    
    
}

