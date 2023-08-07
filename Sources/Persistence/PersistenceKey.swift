
import Foundation

public struct PersistenceKey<Value: Codable> {

    let url: URL
    private let defaultValue: Value

    public init(url: URL, defaultValue: Value) {
        self.url = url
        self.defaultValue = defaultValue
    }
}

extension PersistenceKey {

    /// Creates the file if it doesn't exist.
    // Bit of a hack.
    func createFile() {
        guard !FileManager().fileExists(atPath: url.path) else { return }
        write(defaultValue)
    }

    func read() -> Value {
        if let value = try? JSONDecoder().decode(Value.self, from: Data(contentsOf: url)) {
            return value
        } else {
            return defaultValue
        }
    }

    func write(_ value: Value) {
        try? JSONEncoder().encode(value).write(to: url)
    }
}
