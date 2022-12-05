//
//  FriendViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 27.06.2022.
//

import UIKit
import SDWebImage

class FriendViewController: UITableViewController, UISearchBarDelegate {
    
    // Привязали SearchBar
    @IBOutlet var mySearchBar: UISearchBar!
    
    
    //MARK: -Singletone
    let session = Session.shared
    let service = Service()
    var myFriends = [FriendProperty]()
    var myFriendsPhotos = [FriendPhotos]()
    

    var friends = [
        MyFriend(image: UIImage(named: "avatarLuk"), name: "Лука", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarKostya"), name: "Костя", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarDen"), name: "Денис", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarMargo"), name: "Маргарита", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarAndrey"), name: "Андрей", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarRodion"), name: "Родион", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarMarina"), name: "Марина", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarArkadiu"), name: "Аркадий", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarNikita"), name: "Никита", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarWeka"), name: "Жека", images: imageFriend),
        MyFriend(image: UIImage(named: "avatarBeth"), name: "Лиза", images: imageBeth),
        MyFriend(image: UIImage(named: "avatarSveta"), name: "Света", images: imageFriend)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Друзья"
        
        // регистрация XIB
        tableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXib")
        
        //получение списка друзей
        service.getFriends { answer in
            self.myFriends = answer.response.items

            self.mySearchBar.delegate = self
            self.makeNamesList()
            self.sortCharacterOfNamesAlphabet()

            self.tableView.reloadData()
        }
    }
    
    //не рабочий метод
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tableView.reloadData()
//    }
    
    //эталонный массив с именами для сравнения при поиске
    var namesListFixed: [String] = []
    // массив с именами меняется (при поиске) и используется в таблице
    var namesListModifed: [String] = []
    var letersOfNames: [String] = []
    
    
    // MARK: - Function
    // создание массива из имен пользователей
    func makeNamesList() {
        namesListFixed.removeAll()
        for item in 0...(myFriends.count - 1) {
//            namesListFixed.append(myFriends[item].firstName)
            namesListFixed.append(myFriends[item].firstName + " " + myFriends[item].lastName)
        }
        namesListModifed = namesListFixed
    }

    
    
    //MARK: - sortCharacterOfNamesAlphabet
    
    // создание массива из начальных букв имен пользователей по алфавиту
    func sortCharacterOfNamesAlphabet() {
        var lettersSet = Set<Character>()
        // обнуляем массив на случай повторного использования
        letersOfNames = []
        // создание сета из первых букв имени, чтобы не было повторов
        for name in namesListModifed {
            lettersSet.insert(name[name.startIndex])
        }
        // заполнение массива строк из букв имен
        for letter in lettersSet.sorted() {
            letersOfNames.append(String(letter))
        }
    }
    
    
    //MARK: - getNameFriendForCell
    func getNameFriendForCell(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in namesListModifed.sorted() {
            if letersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }
    
    
    //MARK: - getImageFriendForCell
    func getImageFriendForCell(_ indexPath: IndexPath) -> UIImage? {
        for friend in myFriends {
            let namesRows = getNameFriendForCell(indexPath)
            let rangeNames = "\(friend.firstName)" + " " + "\(friend.lastName)"
            if rangeNames.contains(namesRows) {
                let imageURL = UIImageView()
                imageURL.sd_setImage(with: URL(string: friend.icon!))
                return imageURL.image
            }
        }
        return nil
    }
    

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
    
    
    //MARK: - test getPhotosFriend
    func getPhotosFriend(_ indexPath: IndexPath) -> [sizesPhotosFriend] {
        //let photos = [FriendPhotos]()
        for friend in myFriendsPhotos {
            let namesRows = getNameFriendForCell(indexPath)
            if String(friend.id).contains(namesRows) {
                print("friend.sizes = \(friend.sizes)")
                return friend.sizes
            }
        }
        return []
    }
    
    
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        namesListModifed = searchText.isEmpty ? namesListFixed : namesListFixed.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        sortCharacterOfNamesAlphabet() // создаем заново массив заглавных букв для хедера
        tableView.reloadData()
    }
    
    // отмена поиска (через кнопку Cancel)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.mySearchBar.showsCancelButton = true // показыть кнопку Cancel
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.showsCancelButton = false // скрыть кнопку Cancel
        mySearchBar.text = nil
        makeNamesList() // возвращаем массив имен
        sortCharacterOfNamesAlphabet()  // создаем заново массив заглавных букв для хедера
        tableView.reloadData() //обновить таблицу
        mySearchBar.resignFirstResponder() // скрыть клавиатуру
    }
    
    
    // MARK: - Table view data source

    // список букв для навигации (контрол справа)
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    
    // количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letersOfNames.count
    }

    // количество ячеек в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        for name in namesListModifed {
            if letersOfNames[section].contains(name.first!) {
                countOfRows += 1
            }
        }
        return countOfRows
    }

    // заполнение ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXib",
                                                       for: indexPath) as? XibTableViewCell else {
            preconditionFailure("Error")
        }
        
        cell.imageFriend.image = getImageFriendForCell(indexPath)
        cell.nameFriend.text = getNameFriendForCell(indexPath)
        return cell
    }
    
    // MARK: - Header
    
    // настройка хедера
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        let letter = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        letter.textColor = UIColor.black.withAlphaComponent(0.5)
        letter.text = letersOfNames[section]
        letter.font = UIFont.systemFont(ofSize: 14)
        header.addSubview(letter)
        
        return header
    }
    
//    // хедер тайтл (заглавная буква имен) не работает, если используется "viewForHeaderInSection"
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        letersOfNames[section]
//    }
    

    // идентифицируем нажатие на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CollectionFriends", sender: nil)
    }

//    // создаем переход на следующий вью
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CollectionFriends",
//           let destination = segue.destination as? FriendPhotoViewController,
//           let indexPath = tableView.indexPathForSelectedRow {
//            destination.title = friends[indexPath.row].name
//            destination.arrayImages = friends[indexPath.row].images
//            print(indexPath.row)
//        }
//    }
    
    
    
    // создаем переход на следующий вью
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionFriends",
           let destination = segue.destination as? FriendPhotoViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destination.title = getNameFriendForCell(indexPath)
            //destination.arrayImages = getPhotosFriend(indexPath)
        }
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
