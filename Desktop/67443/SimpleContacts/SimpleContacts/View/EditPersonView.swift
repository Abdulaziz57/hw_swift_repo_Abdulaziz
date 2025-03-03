//
//  EditPersonView.swift
//  SimpleContacts
//
//  Created by Abdulaziz Al Mannai on 03/03/2025.
//

import SwiftUI
import PhotosUI

struct EditPersonView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var details: String = ""
    @State private var photo: String = ""
    @State private var personId: Int64?
    @State private var showAlert: Bool = false

    @State private var avatarImage: UIImage?
    @State private var avatarItem: PhotosPickerItem?

    @State private var alertMessage: String = ""

    private let personService = PersonService.shared

    init(personId: Int64?) {
        _personId = State(initialValue: personId)
    }

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Details", text: $details)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let image = avatarImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                Text("No image selected")
                    .padding()
            }

            PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
                .padding()

            Button("Save") {
                handleSave()
            }
            .padding()
        }
        .padding()
        .onAppear {
            if let personId = personId {
                fetchPerson(personId)
            }
        }
        .navigationBarTitle("Edit Contact", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Validation"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onChange(of: avatarItem) { newItem in
            Task {
                if let imageData = try? await avatarItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: imageData) {
                    avatarImage = uiImage
                } else {
                    print("Failed to load image")
                }
            }
        }
    }

    private func fetchPerson(_ personId: Int64) {
        Task {
            let person = await personService.getPerson(pid: personId)
            if let person = person.first {
                name = person.name
                email = person.email
                details = person.details
                photo = person.photo

                if let imagePath = URL(string: person.photo),
                   let imageData = try? Data(contentsOf: imagePath),
                   let uiImage = UIImage(data: imageData) {
                    avatarImage = uiImage
                }
            }
        }
    }

    private func saveImageToFile(_ image: UIImage) -> String? {
        let fileManager = FileManager.default
        let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        guard let directory = documentDirectory else { return nil }
        
        let fileURL = directory.appendingPathComponent(UUID().uuidString + ".png")
        
        if let data = image.pngData() {
            do {
                try data.write(to: fileURL)
                return fileURL.absoluteString
            } catch {
                print("Error saving image: \(error)")
                return nil
            }
        }
        
        return nil
    }

    private func handleSave() {
        if name.isEmpty || email.isEmpty {
            alertMessage = "Name and email are required."
            showAlert = true
            return
        }
        
        if let image = avatarImage {
            let imagePath = saveImageToFile(image)
            photo = imagePath ?? ""
        }
        
        if let personId = personId, personId > 0 {
            Task {
                print("photo :\(photo)")
                await personService.updatePerson(id: personId, name: name, email: email, details: details, photo: photo)
            }
        } else {
            Task {
                print("inside insert new")
                await personService.insertPerson(name: name, email: email, details: details, photo: photo)
            }
        }
        
        dismiss()
    }
}

#Preview {
    EditPersonView(personId: nil)
}



