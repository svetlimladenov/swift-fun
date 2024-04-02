import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var eventMonitor: Any?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        registerHotKey()
    }

    func registerHotKey() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)

        if !accessEnabled {
            print("Accessibility access is not enabled. Please enable it in System Preferences.")
            return
        }

        let keyCode = UInt16(0x07) // Key code for 'X'
        let keyMask: NSEvent.ModifierFlags = [.command, .shift]

        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { (event) in
            guard let event = event else { return }
            
            if event.keyCode == keyCode && event.modifierFlags.contains(keyMask) {
                print("Command + Shift + X pressed")
                // Your action here
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        if let eventMonitor = eventMonitor {
            NSEvent.removeMonitor(eventMonitor)
        }
    }
}



////
///
////  main.swift
////  DownloadFile
////
////  Created by Svetlin Mladenov on 4.12.23.
////
//
//import Foundation
//import Compression
//
//let auth = "Basic YWRtaW46cEBzc3cwcmQ="
//
//class StreamDownloader: NSObject, URLSessionDataDelegate {
//    private let destinationURL: URL
//    private var offset: UInt64
//    private var completionHandler: ((Error?) -> Void)?
//    
//    init(destinationURL: URL, offset: UInt64, completionHandler: ((Error?) -> Void)? = nil) {
//        self.destinationURL = destinationURL
//        self.offset = offset
//        self.completionHandler = completionHandler
//        
//        super.init()
//    }
//    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
//                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
//        print("Received initial data ")
//        
//        guard let response = response as? HTTPURLResponse,
//            response.statusCode == 200 else {
//            completionHandler(.cancel)
//            return
//        }
//        
//        completionHandler(.allow)
//    }
//    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        if !FileManager.default.fileExists(atPath: destinationURL.path) {
//            FileManager.default.createFile(atPath: destinationURL.path, contents: nil, attributes: nil)
//        }
//        
//        let fileHandle = try? FileHandle(forWritingTo: destinationURL)
//        defer { try? fileHandle?.close()}
//        
//        try? fileHandle?.seek(toOffset: self.offset)
//        fileHandle?.write(data)
//        
//        self.offset += UInt64(data.count)
//    }
//    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        completionHandler?(error)
//    }
//}
//
//
//let destinationURL = URL(fileURLWithPath: "/Users/svetlinmladenov/Library/Containers/com.macstadium.orka-si/Data/orka-si/base/test/asdf")
//let downloadURL = URL(string: "http://orka-registry:8080/v2/orka-images/new/blobs/sha256:3e2c9c6b4996b0b02a54abe4a67bcd9cec052e0a37f85bf3bb0361000aea0193")!
//
////let group = DispatchGroup()
////group.enter()
////
////let downloader = StreamDownloader(destinationURL: destinationURL, offset: 0) { error in
////    if let error = error {
////        print("something went wront \(error)")
////        return
////    }
////    
////    print("Success")
////    group.leave()
////}
////
////let session = URLSession(configuration: .default, delegate: downloader, delegateQueue: nil)
//var request = URLRequest(url: downloadURL)
//request.addValue("application/vnd.oci.image.manifest.v1+json", forHTTPHeaderField: "Accept")
//request.addValue(auth, forHTTPHeaderField: "Authorization")
////
////let task = session.dataTask(with: request)
////task.resume()
////
////group.wait()
//
//enum OutputStreamError: Error {
//    case writeFailure
//}
//
//extension OutputStream {
//
//    /// Write `Data` to `OutputStream`
//    ///
//    /// - parameter data:                  The `Data` to write.
//
//    func write(_ data: Data) throws {
//        try data.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) throws in
//            guard var pointer = buffer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
//                throw OutputStreamError.writeFailure
//            }
//
//            var bytesRemaining = buffer.count
//
//            while bytesRemaining > 0 {
//                let bytesWritten = write(pointer, maxLength: bytesRemaining)
//                if bytesWritten < 0 {
//                    throw OutputStreamError.writeFailure
//                }
//
//                bytesRemaining -= bytesWritten
//                pointer += bytesWritten
//            }
//        }
//    }
//}
//
//func downloadLargeFile(request: URLRequest, destinationURL: URL) async throws -> URL {
//    let (asyncBytes, response) = try await URLSession.shared.bytes(for: request)
//    
//    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//        throw URLError(.badServerResponse)
//    }
//    
//    if !FileManager.default.fileExists(atPath: destinationURL.path) {
//            FileManager.default.createFile(atPath: destinationURL.path, contents: nil, attributes: nil)
//    }
//    
//    let bufferSize = 32 * 1024 * 1024
//    
////    guard let output = OutputStream(url: destinationURL, append: false) else {
////        throw URLError(.cannotOpenFile)
////    }
////    output.open()
//    let fileHandle = try? FileHandle(forWritingTo: destinationURL)
//    try fileHandle?.seek(toOffset: 0)
//    
//    var buffer = Data()
//    buffer.reserveCapacity(bufferSize)
//    
//    
//    var count = 0
//    for try await byte in asyncBytes.lines {
//        count += 1
//        buffer.append(byte)
//        
//        if count >= bufferSize {
//            fileHandle?.write(buffer)
//            buffer.removeAll(keepingCapacity: true)
//        }
//    }
//    
//    if !buffer.isEmpty {
//        fileHandle?.write(buffer)
//    }
//
//    print("Done")
//    return destinationURL
//}
//
//try await downloadLargeFile(request: request, destinationURL: destinationURL)
//    
