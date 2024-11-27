//
//  DocumentDemo.swift
//  HelloSwiftUI
//
//  Created by Kyuhyun Park on 11/26/24.
//

import SwiftUI
import UniformTypeIdentifiers

// https://developer.apple.com/documentation/swiftui/documents
// https://developer.apple.com/documentation/swiftui/documentgroup
// https://developer.apple.com/documentation/swiftui/environmentvalues/opendocument

struct DocumentGroupDemo: View {

    @Environment(\.newDocument) private var newDocument
    @Environment(\.openDocument) private var openDocument

    var body: some View {
        Button("New FileDocument") {
            let sampleString = "In an age of endless noise and fleeting moments, the rarest treasures are found in the quiet places where we reconnect with ourselves."
            let document = SimpleFileDocument(content: sampleString)
            newDocument(document)
        }
        Button("Open FileDocument") {
            Task {
                guard let url = Bundle.main.url(forResource: "Sample", withExtension: "txt") else {
                    fatalError()
                }
                do {
                    try await openDocument(at: url)
                } catch {
                    fatalError()
                }
            }
        }
    }
}

#Preview {
    DocumentGroupDemo()
}