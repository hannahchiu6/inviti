//
//  File.swift
//  inviti
//
//  Created by Hannah.C on 01.06.21.
//

import Foundation
import  Firebase
import FirebaseFirestore

//func fetchCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
//  db.collection(“Courses”)
//   //   .order(by: “name “)
//   .whereField(“teachers”, arrayContains: UserManager.shared.userID!)
//   .getDocuments { (querySnapshot, error) in
//    if let error = error {
//     completion(.failure(error))
//    } else {
//     var courses = [Course]()
//     for document in querySnapshot!.documents {
//      do {
//       if var course = try document.data(as: Course.self, decoder: Firestore.Decoder()) {
//        self.db.collection(“Courses”)
//         .document(“\(course.id)“)
//         .collection(“Lessons”)
//         .order(by: “number”, descending: false)
//         .getDocuments { (querySnapshot, error) in
//          if let error = error {
//           completion(.failure(error))
//          } else {
//           var lessons = [Lesson]()
//           for document in querySnapshot!.documents {
//            do {
//             if let lesson = try document.data(as: Lesson.self, decoder: Firestore.Decoder()) {
//              lessons.append(lesson)
//             }
//            } catch {
//             completion(.failure(error))
//            }
//           }
//           course.lessons = lessons
//           courses.append(course)
//           completion(.success(courses))
//          }
//         }
//        }
//       } catch {
//        completion(.failure(error))
//        // completion(.failure(FirebaseError.documentError))
//       }
//      }
//     }
//    }
//  }
