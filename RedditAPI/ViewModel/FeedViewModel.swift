//
//  Parser.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/17/21.
//

import Foundation
import Combine

class FeedViewModel {
    
    @Published private var errorDescription = ""
    @Published private var rowUpdate = 0
    @Published private var feeds = [ChildData]()
    
    var feedsBinding: Published<[ChildData]>.Publisher { $feeds }
    var errorBinding: Published<String>.Publisher { $errorDescription }
    var rowUpdateBinding: Published<Int>.Publisher { $rowUpdate }
    var count: Int { feeds.count }
    
    private let service: FeedService
    private var publishers = Set<AnyCancellable>()
    
    private var after = ""
    private var isLoading = false
    private var imagesCache = NSCache<NSString, NSData>()
    
    init(service: FeedService = FeedService()) {
        self.service = service
    }
    
    private func downloadImage(urlImage: String, key: NSString, row: Int) {
        service
            .getImage(from: urlImage)
            .sink { _ in }
            receiveValue: { [unowned self] data in
                let nsData = NSData(data: data)
                imagesCache.setObject(nsData, forKey: key)
                rowUpdate = 0
            }
            .store(in: &publishers)
    }
    
    func visibleRows(_ rows: [Int]) {
        let isLastRow = rows.contains(count - 1)
        if isLastRow {
            loadFeeds()
        }
    }
    
    func loadFeeds() {
        guard !isLoading else { return }
        isLoading = true
        
        let newURL = Constants_URL.feedURL.replacingOccurrences(of: Constants_URL.after, with: after)
        
        service
            .getFeeds(from: newURL)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorDescription = error.localizedDescription
                    self?.isLoading = false
                }
            }
            receiveValue: { [weak self] response in
                self?.after = response.data.after
                let feeds = response.data.children.map { $0.data }
                self?.feeds.append(contentsOf: feeds)
                self?.isLoading = false
            }
            .store(in: &publishers)
    }
    
    func getImageData(at row: Int) -> Data? {
        
        guard let urlImage = feeds[row].thumbnail,
              urlImage.contains("https://")
        else { return nil }
        
        let key = NSString(string: urlImage)
        if let data = imagesCache.object(forKey: key) {
            return data as Data
        } else {
            downloadImage(urlImage: urlImage, key: key, row: row)
            return nil
        }
    }
    
    func getTitle(at row: Int) -> String? {
        return feeds[row].title
    }
    
    func getScore(at row: Int) -> String? {
        return "\(feeds[row].score)"
    }
    
    func getNumComments(at row: Int) -> String? {
        return "\(feeds[row].numComments)"
    }
    
    func geterrorDescription() -> String? {
        return errorDescription
    }
}
