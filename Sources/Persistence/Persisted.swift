
import SwiftUI

@propertyWrapper
public struct Persisted<Value: Codable>: DynamicProperty {

    @ObservedObject private var fileObserver: FileObserver
    private let key: PersistenceKey<Value>

    public init(_ key: PersistenceKey<Value>) {
        key.createFile()
        self.fileObserver = FileObserver(url: key.url)
        self.key = key
    }

    public var wrappedValue: Value {
        get { key.read() }
        nonmutating set { key.write(newValue) }
    }

    public var projectedValue: Binding<Value> {
        Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }
}
