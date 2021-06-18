import Foundation
import NetworkingKitInterface

final public class DefaultParserProvider<ParserType: Parser,
                                   ProviderType: Provider>: Provider where ProviderType.ReturnType == Data {
    public var parser: ParserType
    private let provider: ProviderType

    init(parser: ParserType, provider: ProviderType) {
        self.parser = parser
        self.provider = provider
    }

    public func request(resource: Resource,
                        completion: @escaping ResultCompletion<ParserType.ParsableType, Error>) -> CancellableTask? {
        provider.request(resource: resource) { [weak self] (result: Result<Data, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let resultData):
                do {
                    let resultTypeInstance = try self.parser.parse(
                        data: resultData,
                        toType: ParserType.ParsableType.self
                    )
                    completion(.success(resultTypeInstance))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
