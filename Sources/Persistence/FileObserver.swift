
import Combine
import Dispatch
import Foundation

final class FileObserver: ObservableObject {

    let objectWillChange: ObservableObjectPublisher
    private let source: DispatchSourceFileSystemObject

    init(url: URL) {
        let objectWillChange = ObservableObjectPublisher()
        let fileDescriptor = open(url.path, O_EVTONLY)
        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: .all,
            queue: .main)
        source.setEventHandler { objectWillChange.send() }
        source.setCancelHandler { close(fileDescriptor) }
        source.resume()

        self.objectWillChange = objectWillChange
        self.source = source
    }

    deinit {
        source.cancel()
    }
}
