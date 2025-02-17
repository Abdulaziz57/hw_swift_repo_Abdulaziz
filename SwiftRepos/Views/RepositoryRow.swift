import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .font(.headline)
            Text(repository.itemDescription ?? "N/A")
                .font(.subheadline)
                .lineLimit(1)
        }
    }
}
