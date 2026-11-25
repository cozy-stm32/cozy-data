import Foundation

struct SourceDocument: Decodable {
    let url: String
    let revision: String
}

struct ReleaseDocument: Decodable {
    let productVersion: String
    let mcuJSON: SourceDocument
    let mcuSVD: SourceDocument
    let embassy: SourceDocument
}

enum CommandError: Error, CustomStringConvertible {
    case usage
    case invalidRevision(String, String)

    var description: String {
        switch self {
        case .usage:
            "Usage: swift run cozy-data-builder inspect --release /path/release.json"
        case .invalidRevision(let source, let revision):
            "Invalid revision for \(source): \(revision)"
        }
    }
}

@main
enum CozyDataBuilder {
    static func main() throws {
        let arguments = Array(CommandLine.arguments.dropFirst())
        guard arguments.count == 3, arguments[0] == "inspect", arguments[1] == "--release" else {
            throw CommandError.usage
        }
        let releaseURL = URL(fileURLWithPath: arguments[2])
        let document = try JSONDecoder().decode(ReleaseDocument.self, from: Data(contentsOf: releaseURL))
        print("Cozy data \(document.productVersion)")
        for (name, source) in [
            ("mcuJSON", document.mcuJSON),
            ("mcuSVD", document.mcuSVD),
            ("embassy", document.embassy),
        ] {
            let revision = source.revision
            guard [40, 64].contains(revision.count),
                  revision.allSatisfy({ $0.isHexDigit && !$0.isUppercase }) else {
                throw CommandError.invalidRevision(name, revision)
            }
            print("\(name): \(source.url) \(revision)")
        }
    }
}
