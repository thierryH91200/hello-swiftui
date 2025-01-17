//
//  SimpleFileDocument.swift
//  HelloSwiftUI
//
//  Created by Kyuhyun Park on 11/27/24.
//

import SwiftUI
import UniformTypeIdentifiers

// https://developer.apple.com/documentation/swiftui/documentgroup
// https://developer.apple.com/documentation/swiftui/filedocument

// https://developer.apple.com/documentation/uniformtypeidentifiers
// https://developer.apple.com/documentation/uniformtypeidentifiers/defining-file-and-data-types-for-your-app

struct SimpleFileDocument: FileDocument {

    static var readableContentTypes: [UTType] { [.plainText] }

    var content: String

    init(content: String = "") {
        self.content = content
    }

    // https://developer.apple.com/documentation/swiftui/filedocumentreadconfiguration
    // https://developer.apple.com/documentation/foundation/filewrapper

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        content = string
    }

    // 파일 저장하려면 프로젝트 퍼미션 변경이 필요하다.
    // Project -> Targets -> Signing & Capabilities
    // -> App Sandbox -> File Access -> User Selected File -> Read/Write

    // https://developer.apple.com/documentation/swiftui/filedocumentwriteconfiguration
    // https://developer.apple.com/documentation/foundation/filewrapper

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(content.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

struct SimpleFileDocumentView: View {

    @Binding var document: SimpleFileDocument

    var body: some View {
        TextEditor(text: $document.content)
            .font(.custom("HelveticaNeue", size: 18))
            .lineSpacing(5)
            .scenePadding()
    }
}
