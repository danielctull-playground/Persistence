
import Persistence
import SwiftUI

struct Person: Codable {
    var name: String
}

extension PersistedKey where Value == Person {
    static let person = Self(
        url: URL.documentsDirectory.appendingPathComponent("Person"),
        defaultValue: Person(name: ""))
}

struct PersonEditor: View {
    @Binding var person: Person
    var body: some View {
      TextField("Name", text: $person.name)
    }
}

struct PersonView: View {
    @Persisted(.person) private var person
    var body: some View {
        VStack {
            Text(person.name)
            PersonEditor(person: $person)
        }
        .padding()
    }
}

struct ContentView: View {

    @Persisted(.person) private var person

    var body: some View {
        Text("Hello, \(person.name)!")
            .foregroundColor(.orange)
        HStack {
            PersonView()
            PersonView()
        }
    }
}
