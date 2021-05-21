////
////  PublishViewModel.swift
////  Publisher
////
////  Created by Wayne Chen on 2020/11/20.
////
//
//import Foundation
//
//class PublishViewModel {
//
//    var article: Article = Article(
//        id: "",
//        title: "",
//        content: "",
//        createdTime: -1,
//        category: "",
//        author: UserManager.shared.author
//    )
//
//    func onTitleChanged(text title: String) {
//        self.article.title = title
//    }
//
//    func onCategoryChanged(text category: String) {
//        self.article.category = category
//    }
//
//    func onContentChanged(text content: String) {
//        self.article.content = content
//    }
//
//    var onPublished: (()->())?
//
//    func onTapPublish() {
//
//        if hasAuthorInArticle() {
//            print("has author in article...")
//            publish() // MARK: check which function this call is
//
//        } else {
//            print("login...")
//            UserManager.shared.login() { [weak self] result in
//                // MARK: - put your id into login function
//                switch result {
//
//                case .success(let author):
//
//                    print("login success")
//                    self?.publish(with: author) // MARK: check which function this call is
//
//                case .failure(let error):
//
//                    print("login.failure: \(error)")
//                }
//
//            }
//        }
//    }
//
//    func publish(with article: inout Article) {
//        XXXManager.shared.publishArticle(article: &article) { result in
//
//            switch result {
//
//            case .success:
//
//                print("onTapPublish, success")
//                self.onPublished?()
//
//            case .failure(let error):
//
//                print("publishArticle.failure: \(error)")
//            }
//        }
//    }
//
//    func publish(with author: Author? = nil) {
//
//        if let author = author {
//            article.author = author
//        }
//
//        publish(with: &article) // MARK: check which function this call is
//    }
//
//    func hasAuthorInArticle() -> Bool {
//        return article.author != nil
//    }
//}
