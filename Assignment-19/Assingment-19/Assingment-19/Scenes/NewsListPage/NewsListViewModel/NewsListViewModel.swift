//
//  NewsListViewModel.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

final class NewsListViewModel {
    private let networkService = NetworkService()
    
    private var articles: [Article] = []
    var currentPage: Int = 1
    private var isFetching: Bool = false
    private let apiKey: String = "05ef21c598fa49b99e1880e226342bcf"
    
    init() {
        fetchNewsData(page: currentPage)
    }
    
    var numberOfArticles: Int {
        articles.count
    }
    
    var articlesChanged: (() -> Void)?
    
    func article(at index: Int) -> Article {
        articles[index]
    }
    
    func fetchNewsData(page: Int) {
        guard !isFetching else { return }
        
        isFetching = true
        let urlString = "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&pageSize=10&page=\(page)&apiKey=\(apiKey)"
        
        networkService.fetchData(urlString: urlString) { [weak self] (newsesData: News?, error: Error?) in
            if let newArticles = newsesData?.articles {
                self?.articles.append(contentsOf: newArticles)
                self?.currentPage += 1
                self?.articlesChanged?()
            }
            self?.isFetching = false
        }
    }
}
