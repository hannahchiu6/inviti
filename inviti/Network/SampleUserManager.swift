////
////  SampleUserManager.swift
////  inviti
////
////  Created by Hannah.C on 20.05.21.
////
//
//import Foundation
//import Firebase
//import FirebaseDatabase
//import FirebaseStorage
//
//
//class SampleUserManager {
//    
////    static let shared: UserManager = UserManager()
//
//    private init() {}
//
//    var name = "No Username"
//
//    var email =  ""
//
//    var image = ""
//
//    var currentUser: User?
//
//    // MARK: Firebase Reference
//
//    let ref: DatabaseReference = Database.database().reference()
//
//    let usersRef: DatabaseReference = Database.database().reference().child("users")
//
//    let profilePhotoStorageRef: StorageReference = Storage.storage().reference().child("image")
//
//    // MARK: - Check if first time sign in
//
//    func checkFirstTimeSignIn(completion: @escaping (Bool?) -> Void) {
//
//        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
//
//            var isFirstTime = true
//
//            let uid = Auth.auth().currentUser?.uid
//
//            guard let allUsers = snapshot.children.allObjects as? [DataSnapshot] else {
//                print("There's no user.")
//                return
//            }
//
//            for user in allUsers {
//                if user.key == uid {
//                    isFirstTime = false
//                    break
//                } else {
//                    isFirstTime = true
//                }
//            }
//            completion(isFirstTime)
//        }
//    }
//
//    // MARK: - Check if the username has been used
//
//    func checkUsername(username: String, completion: @escaping (Bool?) -> Void) {
//
//        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
//
//            var hasBeenUsed: Bool?
//
//            guard let allUsers = snapshot.children.allObjects as? [DataSnapshot] else {
//                print("There's no user.")
//                return
//            }
//
//            for user in allUsers {
//                let value = user.value as? [String: Any] ?? [:]
//
//                guard let valueUsername = value["username"] as? String else {
//                    print("There's no username.")
//                    return
//                }
//
//                if valueUsername == username {
//                    hasBeenUsed = true
//                } else {
//                    hasBeenUsed = false
//                }
//            }
//            completion(hasBeenUsed)
//        }
//    }
//
//    // MARK: - Get the author info
//
//    func getAuthorInfo(userId: String, completion: @escaping (User) -> Void) {
//
//        // Call Firebase API to retrieve the user info
//        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
//
//            let userInfo = snapshot.value as? [String: Any] ?? [:]
//
//            guard let user = User(userId: userId, userInfo: userInfo) else {
//                print("------ Author not found ------")
//                return
//            }
//            completion(user)
//        }
//    }
//
//    // MARK: - Get the user info
//
//    func getCurrentUserInfo(userId: String, completion: @escaping (User) -> Void) {
//
//        // Call Firebase API to retrieve the user info
//        ref.child("users").child(userId).observe(.value) { (snapshot) in
//
//            let userInfo = snapshot.value as? [String: Any] ?? [:]
//
//            guard let user = User(userId: userId, userInfo: userInfo) else {
//                print("------ User not found: \(userId) ------")
//                return
//            }
//
//            // Save user info to local UserManager
//            self.currentUser = user
//
//            completion(user)
//        }
//    }
//
//    // MARK: - Add a user on DB
//
//    func addUser(image: UIImage, completion: @escaping () -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let userRef = ref.child("users").child(userId)
//
//        // Use the unique key as the image name and prepare the storage reference
//        guard let imageKey = userRef.key else { return }
//        let imageStorageRef = profilePhotoStorageRef.child("\(imageKey).jpg")
//
//        // Resize the image
//        let scaledImage = image.scale(newWidth: 200)
//        guard let imageData = scaledImage.jpegData(compressionQuality: 0.7) else { return }
//
//        // Create the file metadata
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//
//        // Prepare the upload task
//        let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
//
//        // Observe the upload status
//        uploadTask.observe(.success) { (snapshot) in
//
//            // Add a reference in the database
//            snapshot.reference.downloadURL(completion: { (url, error) in
//                let username = self.username
//
//                guard let url = url else { return }
//                let profileImage = url.absoluteString
//                self.profileImage = profileImage
//
//                let fullName = self.fullName
//                let bio = ""
//                let posts: [String] = [""]
//                let followRequests: [String] = [""]
//                let followers: [String] = [""]
//                let following: [String] = [""]
//                let postDidLike: [String] = [""]
//                let bookmarks: [String] = [""]
//                let ignoreList: [String] = [""]
//                let joinedDate = Int(Date().timeIntervalSince1970 * 1000)
//                let lastLogin = Int(Date().timeIntervalSince1970 * 1000)
//                let isPrivate = false
//                let isOnline = true
//                let isMapLocationEnabled = false
//
//                let user: [String: Any] = [
//                    "username": username,
//                    "profileImage": profileImage,
//                    "fullName": fullName,
//                    "bio": bio,
//                    "posts": posts,
//                    "followRequests": followRequests,
//                    "followers": followers,
//                    "following": following,
//                    "postDidLike": postDidLike,
//                    "bookmarks": bookmarks,
//                    "ignoreList": ignoreList,
//                    "joinedDate": joinedDate,
//                    "lastLogin": lastLogin,
//                    "isPrivate": isPrivate,
//                    "isOnline": isOnline,
//                    "isMapLocationEnabled": isMapLocationEnabled
//                ]
//                userRef.setValue(user)
//            })
//            // Describe what to do at where uploadPost() is called.
//            completion()
//        }
//
//        uploadTask.observe(.progress) { (snapshot) in
//            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
//            print("Uploading... \(percentComplete)% complete")
//        }
//
//        uploadTask.observe(.failure) { (snapshot) in
//            if let error = snapshot.error {
//                print("Upload error -> ", error.localizedDescription)
//            }
//        }
//    }
//
//    // MARK: - Update All User Info
//
//    func updateAllUserInfo(completion: @escaping () -> Void) {
//
//        // MARK: Update DB
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        guard let username = currentUser?.username else { return }
//        guard let profileImage = currentUser?.profileImage else { return }
//        guard let fullName = currentUser?.fullName else { return }
//        guard let bio = currentUser?.bio else { return }
//        guard let posts: [String] = self.currentUser?.posts else { return }
//        guard let followRequests: [String] = self.currentUser?.followRequests else { return }
//        guard let followers: [String] = self.currentUser?.followers else { return }
//        guard let following: [String] = self.currentUser?.following else { return }
//        guard let postDidLike: [String] = self.currentUser?.postDidLike else { return }
//        guard let bookmarks: [String] = self.currentUser?.bookmarks else { return }
//        guard let ignoreList: [String] = self.currentUser?.ignoreList else { return }
//        guard let joinedDate = self.currentUser?.joinedDate else { return }
//        let lastLogin = Int(Date().timeIntervalSince1970 * 1000)
//        guard let isPrivate = self.currentUser?.isPrivate else { return }
//        guard let isOnline = self.currentUser?.isOnline else { return }
//        guard let isMapLocationEnabled = self.currentUser?.isMapLocationEnabled else { return }
//
//        let user: [String: Any] = [
//            "username": username,
//            "profileImage": profileImage,
//            "fullName": fullName,
//            "bio": bio,
//            "posts": posts,
//            "followRequests": followRequests,
//            "followers": followers,
//            "following": following,
//            "postDidLike": postDidLike,
//            "bookmarks": bookmarks,
//            "ignoreList": ignoreList,
//            "joinedDate": joinedDate,
//            "lastLogin": lastLogin,
//            "isPrivate": isPrivate,
//            "isOnline": isOnline,
//            "isMapLocationEnabled": isMapLocationEnabled
//        ]
//
//        let childUpdates = ["\(userId)": user]
//
//        self.ref.child("users").updateChildValues(childUpdates)
//
//        completion() // do something after updating
//    }
//
//    // MARK: - Update User Profile Info
//
//    func updateUserProfile(image: UIImage, fullName: String, username: String, bio: String, completion: @escaping () -> Void) {
//
//        // MARK: Update local UserManager for instantly use
//        currentUser?.fullName = fullName
//        currentUser?.username = username
//        currentUser?.bio = bio
//
//        // MARK: Update DB
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let userRef = ref.child("users")
//        guard let imageKey = userRef.key else { return }
//        let imageStorageRef = profilePhotoStorageRef.child("\(imageKey).jpg")
//
//        let scaledImage = image.scale(newWidth: 200)
//        guard let imageData = scaledImage.jpegData(compressionQuality: 1.0) else { return }
//
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//
//        let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
//
//        uploadTask.observe(.success) { (snapshot) in
//
//            snapshot.reference.downloadURL { (url, error) in
//
//                guard let url = url else { return }
//                let profileImage = url.absoluteString
//
//                // for local use
//                self.profileImage = profileImage
//                self.currentUser?.profileImage = profileImage
//
//                userRef.child(userId).child("username").setValue(username)
//                userRef.child(userId).child("profileImage").setValue(profileImage)
//                userRef.child(userId).child("fullName").setValue(fullName)
//                userRef.child(userId).child("bio").setValue(bio)
//            }
//        }
//        completion() // do something after updating
//    }
//
//    // MARK: - Update /users/userId/posts for deleting & editing
//
//    func updateUserPosts(completion: @escaping () -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        guard let posts = self.currentUser?.posts else { return }
//        usersRef.child(userId).child("posts").setValue(posts)
//        completion() // do something after updating
//    }
//
//    // MARK: - Update Post Like Count
//
//    func updateLikeCount(completion: @escaping () -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        guard let postDidLike = self.currentUser?.postDidLike else { return }
//
//        usersRef.child(userId).child("postDidLike").setValue(postDidLike)
//        completion() // do something after updating
//    }
//
//    // MARK: - Update isMapLocationEnabled
//
//    func updateIsMapLocationEnabled() {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        guard let isMapLocationEnabled = self.currentUser?.isMapLocationEnabled else { return }
//
//        usersRef.child(userId).child("isMapLocationEnabled").setValue(isMapLocationEnabled)
//    }
//
//    // MARK: - Update /users/uid/ignoreList for hiding the post/comment/user
//
//    // For current user
//    func updateCurrentUserIgnoreList(with id: String, completion: @escaping () -> Void) {
//        // Add the userId to currentUser's ignoreList
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard var ignoreList = self.currentUser?.ignoreList else { return }
//        ignoreList.append(id)
//        ignoreList.removeDuplicates()
//
//        usersRef.child(uid).child("ignoreList").setValue(ignoreList)
//        completion()
//    }
//
//    // For the blocked user
//    func updateBlockedUserIgnoreList(with user: User, completion: @escaping () -> Void) {
//        // Add currentUser's userId to the blocked user's ignoreList
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        var ignoreList = user.ignoreList
//        ignoreList.append(uid)
//        ignoreList.removeDuplicates()
//
//        usersRef.child(user.userId).child("ignoreList").setValue(ignoreList)
//        completion()
//    }
//
//    // MARK: - Block the User
//
//    func block(with user: User, completion: @escaping () -> Void) {
//
//        // For current user
//        self.updateCurrentUserIgnoreList(with: user.userId) {}
//
//        // For the blocked user
//        self.updateBlockedUserIgnoreList(with: user) {}
//
//        // Unfollow each other
//        FollowManager.shared.unfollow(the: user)
//        FollowManager.shared.remove(the: user) {}
//
//        // Block the user & Reload data
//        completion()
//    }
//}
