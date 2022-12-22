//
//  FriendViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit
import SDWebImage
import RealmSwift

class FriendViewController: UITableViewController, UISearchBarDelegate {
    
    // Привязали SearchBar
    @IBOutlet var mySearchBar: UISearchBar!
    
    
    //MARK: - Singletone
    
    let session = Session.shared
    let service = Service.shared
//    var myFriends = [FriendProperty]()
//    var myFriendsPhotos = [FriendPhotos]()
    
    var friends: [VkUsers]?
    var sortedFriends = [Character: [VkUsers]]()
    
    let refresh = UIRefreshControl()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Друзья"
        
        self.tabBarController?.tabBar.backgroundColor = .systemYellow
        
        
        
        // регистрация XIB
        tableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXib")
        
        
        guard let realm = RealmHelper.getRealm() else { return }
        
        //MARK: Проверка на существование объекта Users в Realm
        let users = realm.objects(VkUsers.self)
        
        if users.isEmpty {
            self.refreshData(self)
        }
        else {
            self.setUsers(Array(users))
        }
        
        
//        //получение списка друзей
//        service.getFriends(token: session.token, id: session.userID) { [weak self] answer in
//
//            guard let self = self else { return }
//
//            self.service.getUsers(token: self.session.token, ids: answer) { [weak self] users in
//
//                guard let self = self else { return }
//
//                self.friends = users
//                self.sortedFriends = self.sort(friends: self.friends ?? nil)
//
//                self.tableView.reloadData()
//            }
//        }
    }
    
    
    
    
    @objc private func refreshData (_ sender: AnyObject) {
        
        service.getFriends(token: session.token, id: session.userID) {[weak self] res in

            guard let self = self else { return }
            
            self.service.getUsers(token: self.session.token, ids: res) { [weak self] res in
                
                guard let self = self else { return }
                
                guard let realm = RealmHelper.getRealm() else { return }
                let users = realm.objects(VkUsers.self)
                
                self.setUsers(Array(users))
                
                if self.refresh.isRefreshing {
                    self.refresh.endRefreshing()
                }
            }
        }
    }
    
    
    private func setUsers(_ users: [VkUsers]) {
        self.friends = users
        
        self.sortedFriends = self.sort(friends: self.friends ?? nil)

        self.tableView.reloadData()
    }
    
    
    private func sort(friends: [VkUsers]?) -> [Character: [VkUsers]] {
        
        var friendsDict = [Character: [VkUsers]]()
        
        guard let friends = friends else { return friendsDict }
        
        friends.forEach() { friend in
            guard let firstChar = friend.first_name?.first else {return}
            
            if var thisFriend = friendsDict[firstChar] {
                thisFriend.append(friend)
                friendsDict[firstChar] = thisFriend
            } else {
                friendsDict[firstChar] = [friend]
            }
                    
        }
        
        return friendsDict
    }
    
    
//    var sortedFriends = [Character: [VkUsersGetResponse]]()
//
//    private func sort(friends: [VkUsersGetResponse]?) -> [Character: [VkUsersGetResponse]] {
//
//        var friendsDict = [Character: [VkUsersGetResponse]]()
//
//        guard let friends = friends else { return friendsDict }
//
//        friends.forEach() { friend in
//            guard let firstChar = friend.first_name?.first else {return}
//
//            if var thisFriend = friendsDict[firstChar] {
//                thisFriend.append(friend)
//                friendsDict[firstChar] = thisFriend
//            } else {
//                friendsDict[firstChar] = [friend]
//            }
//        }
//        return friendsDict
//    }
    
    
    
        // создаем переход на следующий вью
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            guard let indexPath = sender as? IndexPath else { return }
            
            let friend = getFriendByIndexPath(indexPath)
            if segue.identifier == "CollectionFriends",
               let destination = segue.destination as? FriendPhotoViewController {
                destination.title = friend.fullName
                destination.userId = friend.id
                print(indexPath.row)
            }
        }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedFriends.keys.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keySorted = sortedFriends.keys.sorted()
        let friends = sortedFriends[keySorted[section]]?.count ?? 0
        
        return friends
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sortedFriends.keys.sorted()[section])
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXib",
                                                       for: indexPath) as? XibTableViewCell else {
            preconditionFailure("Error")
        }
        let friend = getFriendByIndexPath(indexPath)
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = cell.imageFriend.layer.position.x + 50
        animation.toValue = cell.imageFriend.layer.position.x
        animation.stiffness = 200
        animation.mass = 1
        //animation.duration = 1
        animation.autoreverses = false
        animation.repeatCount = 1
        animation.beginTime = CACurrentMediaTime()
        //animation.fillMode = CAMediaTimingFillMode.backwards
        cell.imageFriend.layer.add(animation, forKey: nil)
        
        if #available(iOS 15, *) {
            Utilities().UrlToImage(url: friend.photo_400_orig) { res in
                cell.imageFriend.image = res
            }
        } else {
            // Fallback on earlier versions
        }
        cell.nameFriend.text = friend.fullName
        
        return cell
    }

    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFriends.keys.sorted().map({ String($0) })
    }
    

    
    func getFriendByIndexPath(_ indexPath: IndexPath) -> VkUsers {
        var friend: VkUsers
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        
        let friends = sortedFriends[firstChar]!
        
        friend = friends[indexPath.row]
        
        return friend
    }
    
    
//    //эталонный массив с именами для сравнения при поиске
//    var namesListFixed: [String] = []
//    // массив с именами меняется (при поиске) и используется в таблице
//    var namesListModifed: [String] = []
//    var letersOfNames: [String] = []
//
//
//    // MARK: - Function
//    // создание массива из имен пользователей
//    func makeNamesList() {
//        namesListFixed.removeAll()
//        for item in 0...(myFriends.count - 1) {
//            namesListFixed.append(myFriends[item].firstName + " " + myFriends[item].lastName)
//        }
//        namesListModifed = namesListFixed
//    }
//
//    //MARK: - sortCharacterOfNamesAlphabet
//    // создание массива из начальных букв имен пользователей по алфавиту
//    func sortCharacterOfNamesAlphabet() {
//        var lettersSet = Set<Character>()
//        // обнуляем массив на случай повторного использования
//        letersOfNames = []
//        // создание сета из первых букв имени, чтобы не было повторов
//        for name in namesListModifed {
//            lettersSet.insert(name[name.startIndex])
//        }
//        // заполнение массива строк из букв имен
//        for letter in lettersSet.sorted() {
//            letersOfNames.append(String(letter))
//        }
//    }
//
//
//    //MARK: - getNameFriendForCell
//    func getNameFriendForCell(_ indexPath: IndexPath) -> String {
//        var namesRows = [String]()
//        for name in namesListModifed.sorted() {
//            if letersOfNames[indexPath.section].contains(name.first!) {
//                namesRows.append(name)
//            }
//        }
//        return namesRows[indexPath.row]
//    }
//
//
//    //MARK: - getImageFriendForCell
//    func getImageFriendForCell(_ indexPath: IndexPath) -> UIImage? {
//        for friend in myFriends {
//            let namesRows = getNameFriendForCell(indexPath)
//            let rangeNames = "\(friend.firstName)" + " " + "\(friend.lastName)"
//            if rangeNames.contains(namesRows) {
//                let imageURL = UIImageView()
//                imageURL.sd_setImage(with: URL(string: friend.icon!))
//                return imageURL.image
//            }
//        }
//        return nil
//    }


        //MARK: - original #getImageFriendForCell
    //    func getImageFriendForCell(_ indexPath: IndexPath) -> UIImage? {
    //        for friend in friends {
    //            let namesRows = getNameFriendForCell(indexPath)
    //            if friend.name.contains(namesRows) {
    //                return friend.image
    //            }
    //        }
    //        return nil
    //    }


//    //MARK: - test getPhotosFriend
//    func getPhotosFriend(_ indexPath: IndexPath) -> [sizesPhotosFriend] {
//        //let photos = [FriendPhotos]()
//        for friend in myFriendsPhotos {
//            let namesRows = getNameFriendForCell(indexPath)
//            if String(friend.id).contains(namesRows) {
//                print("friend.sizes = \(friend.sizes)")
//                return friend.sizes
//            }
//        }
//        return []
//    }


    //    //MARK: - getPhotosFriend
    //    func getPhotosFriend(_ indexPath: IndexPath) -> [ImagesFriend] {
    //        let photos = [ImagesFriend]()
    //        for friend in friends {
    //            let namesRows = getNameFriendForCell(indexPath)
    //            if friend.name.contains(namesRows) {
    //                //photos =
    //
    //                return friend.images
    //            }
    //        }
    //        return photos
    //    }



    // MARK: - SearchBar
    // поиск по именам
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        namesListModifed = searchText.isEmpty ? namesListFixed : namesListFixed.filter { (item: String) -> Bool in
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//        sortCharacterOfNamesAlphabet() // создаем заново массив заглавных букв для хедера
//        tableView.reloadData()
//    }
//
//    // отмена поиска (через кнопку Cancel)
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.mySearchBar.showsCancelButton = true // показыть кнопку Cancel
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        mySearchBar.showsCancelButton = false // скрыть кнопку Cancel
//        mySearchBar.text = nil
//        makeNamesList() // возвращаем массив имен
//        sortCharacterOfNamesAlphabet()  // создаем заново массив заглавных букв для хедера
//        tableView.reloadData() //обновить таблицу
//        mySearchBar.resignFirstResponder() // скрыть клавиатуру
//    }
//
//
//    // MARK: - Table view data source
//
//    // список букв для навигации (контрол справа)
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return letersOfNames
//    }
//
//    // количество секций
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return letersOfNames.count
//    }
//
//    // количество ячеек в секции
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var countOfRows = 0
//        for name in namesListModifed {
//            if letersOfNames[section].contains(name.first!) {
//                countOfRows += 1
//            }
//        }
//        return countOfRows
//    }
//
//    // заполнение ячеек
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXib",
//                                                       for: indexPath) as? XibTableViewCell else {
//            preconditionFailure("Error")
//        }
//
//        cell.nameFriend.text = getNameFriendForCell(indexPath)
//        cell.imageFriend.image = getImageFriendForCell(indexPath)
//
//        return cell
//    }

//    // MARK: - Header
//
//    // настройка хедера
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
//
//        let letter = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
//        letter.textColor = UIColor.black.withAlphaComponent(0.5)
//        letter.text = letersOfNames[section]
//        letter.font = UIFont.systemFont(ofSize: 14)
//        header.addSubview(letter)
//
//        return header
//    }

    //    // хедер тайтл (заглавная буква имен) не работает, если используется "viewForHeaderInSection"
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        letersOfNames[section]
    //    }


    // идентифицируем нажатие на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CollectionFriends", sender: indexPath)
    }


   



//    // создаем переход на следующий вью
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CollectionFriends",
//           let destination = segue.destination as? FriendPhotoViewController,
//           let indexPath = tableView.indexPathForSelectedRow {
//            destination.title = getNameFriendForCell(indexPath)
//            //destination.arrayImages = getPhotosFriend(indexPath)
//        }
//    }

    
    //
    //    /*
    //    // Override to support conditional editing of the table view.
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        // Return false if you do not want the specified item to be editable.
    //        return true
    //    }
    //    */
    //
    //    /*
    //    // Override to support editing the table view.
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            // Delete the row from the data source
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        } else if editingStyle == .insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //        }
    //    }
    //    */
    //
    //    /*
    //    // Override to support rearranging the table view.
    //    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //
    //    }
    //    */
    //
    //    /*
    //    // Override to support conditional rearranging of the table view.
    //    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    //        // Return false if you do not want the item to be re-orderable.
    //        return true
    //    }
    //    */
    //
    //    /*
    //    // MARK: - Navigation
    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //    }
    //    */
    
}
