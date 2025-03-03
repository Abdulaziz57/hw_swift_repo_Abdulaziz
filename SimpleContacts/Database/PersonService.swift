//
//  PersonService.swift
//  SimpleContacts
//
//  Created by Abdulaziz Al Mannai on 03/03/2025.
//

import Foundation
import SQLite


class PersonService {
    static let shared = PersonService()

    // SQLite instance
    private var db: Connection!

    // Table instance
    private let peopleTable = Table("Person")

    // Column instances of table "Person"
    private let id = SQLite.Expression<Int64>("id")
    private let name = SQLite.Expression<String>("name")
    private let email = SQLite.Expression<String>("email")
    private let details = SQLite.Expression<String>("details")
    private let photo = SQLite.Expression<String>("photo")

    func initializeDatabase() async {
        do {
            // Path of document directory
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

            // Creating database connection
            db = try Connection("\(path)/SimpleContactsDB.sqlite3")

            // Table creation
            createTable()

            let result: [Person] = await getPeople()
            if result.isEmpty {
                await insertPerson(name: "Bob", email: "test@example.com", details: "test", photo: "test.jpg")
                // Insert two more people here!
            }
            print("Database Initialized Successfully")
        } catch {
            print("Error Initializing Database: \(error)")
        }
    }

    func createTable() {
        do {
            // Query for creating table, if not exists
            let createTable = peopleTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(name)
                table.column(email)
                table.column(details)
                table.column(photo)
            }
            // Run the query for table creation
            try db.run(createTable)
            print("Table created successfully")
        } catch {
            // Handle any errors during table creation
            print("Error creating table: \(error)")
        }
    }

    func insertPerson(name: String, email: String, details: String, photo: String) async {
        do {
            let insert_query = peopleTable.insert(
                self.name <- name,
                self.email <- email,
                self.details <- details,
                self.photo <- photo
            )
            let insertedId = try db.run(insert_query)
            print("Person inserted successfully with id: \(insertedId)")
        } catch {
            print("Error inserting person: \(error)")
        }
    }

    func updatePerson(id: Int64, name: String, email: String, details: String, photo: String) async {
        let person = peopleTable.filter(self.id == id)
        do {
            let update_query = person.update(
                self.name <- name,
                self.email <- email,
                self.details <- details,
                self.photo <- photo
            )
            let updatedId = try db.run(update_query)
            print("Person updated successfully with id: \(updatedId)")
        } catch {
            print("Error updating person: \(error)")
        }
    }

    func getPeople() async -> [Person] {
        var people: [Person] = []
        
        guard let db = db else {
            print("Error: Database connection is nil.")
            return []
        }

        do {
            for person in try db.prepare(peopleTable) {
                if let personId = person[id] as Int64?,
                   let personName = person[name] as String?,
                   let personEmail = person[email] as String?,
                   let personDetails = person[details] as String?,
                   let personPhoto = person[photo] as String? {
                    
                    people.append(
                        Person(id: personId,
                               name: personName,
                               email: personEmail,
                               details: personDetails,
                               photo: personPhoto)
                    )
                } else {
                    print("Skipping entry due to nil values.")
                }
            }
        } catch {
            print("Error retrieving people: \(error)")
        }
        return people
    }




    func getPerson(pid: Int64) async -> [Person] {
        var people: [Person] = []
        do {
            for person in try db.prepare(peopleTable.filter(id == pid)) {
                people.append(
                    Person(id: person[id],
                           name: person[name],
                           email: person[email],
                           details: person[details],
                           photo: person[photo])
                )
            }
        } catch {
            print("Error retrieving people: \(error)")
        }
        return people
    }

    func deletePerson(id: Int64) {
        let person = peopleTable.filter(self.id == id)
        do {
            try db.run(person.delete())
            print("Contact deleted successfully")
        } catch {
            print("Error deleting person: \(error)")
        }
    }
}








