import Foundation

class ViewModel: ObservableObject {
  
  // instance of parser
  
  // MARK: Fields
    
    @Published var repos: [Repository] = []
    @Published var searchText: String = ""
    @Published var fileteredRepos: [Repository] = []

    private let parser = Parser()

  // MARK: Methods
    
  
  func search(searchText: String) {
      fileteredRepos = repos.filter {repo in
          return repo.name.lowercased().contains(searchText.lowercased())
      }

  }
}
