//
//  PeopleView.swift
//  SimpleContacts
//
//  Created by Abdulaziz Al Mannai on 03/03/2025.
//

import SwiftUI

struct PeopleView: View {
    @State private var people: [Person] = []
    @State private var searchText: String = ""
    @State private var isSorted: Bool = false

    private let personService = PersonService.shared

    var body: some View {
        NavigationStack {
            VStack {
                header
                searchBar
                contactList
            }
            .onAppear {
                Task {
                    await fetchPeople()
                }
            }
        }
    }

    private func fetchPeople() async {
        let fetchedPeople = await personService.getPeople()
        self.people = fetchedPeople
    }

    private var header: some View {
        HStack {
            Text("My Contacts")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 15)

            Spacer()

            Button(action: handleSort) {
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                    .padding(.trailing, 15)
            }

            NavigationLink(destination: EditPersonView(personId: nil)) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                    .padding(.trailing, 15)
            }
        }
        .padding(.vertical, 10)
    }

    private func handleSort() {
        isSorted.toggle()
        if isSorted {
            people.sort { $0.name < $1.name }
        } else {
            people.sort { $0.name > $1.name }
        }
    }

    private var searchBar: some View {
        TextField("Search", text: $searchText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    private var contactList: some View {
        List {
            ForEach(people.filter { person in
                searchText.isEmpty ||
                person.name.lowercased().contains(searchText.lowercased())
            }, id: \.id) { person in
                HStack {
                    Text(person.name)
                        .fontWeight(.bold)
                        .font(.body)

                    Spacer()

                    NavigationLink(destination: EditPersonView(personId: person.id)) {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.gray)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        Task {
                            if let personId = person.id { 
                                await deletePerson(personId)
                            } else {
                                print("Error: Attempted to delete a contact with a nil ID.")
                            }
                        }
                    } label: {
                        Text("Delete")
                    }
                }
            }
        }
    }

    private func deletePerson(_ id: Int64) async {
        await personService.deletePerson(id: id)
        await fetchPeople()
    }
}

#Preview {
    PeopleView()
}
