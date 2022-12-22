//
//  GroupsTableViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 30.06.2022.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    
//    var groups = [
//    
//        Group(name: "Семья", image: UIImage(named: "family")),
//        Group(name: "Отдых в лесу", image: UIImage(named: "rest"))
//        
//    ]
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Группы"
//        
//        tableView.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXib")
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return groups.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXib",
//                                                       for: indexPath) as! XibTableViewCell
//
//        let content = cell
//        content.imageFriend.image = groups[indexPath.row].image
//        content.nameFriend.text = groups[indexPath.row].name
//        
//        cell.contentConfiguration = content as? UIContentConfiguration
//
//        return cell
//    }
//    
//    
//    @IBAction func addSelectGroup(segue: UIStoryboardSegue) {
//        if let sourceVC = segue.source as? AddGroupTableViewController,
//           let indexPath = sourceVC.tableView.indexPathForSelectedRow {
//            
//            let myGroup = sourceVC.addGroup[indexPath.row]
//            
//            if !groups.contains(where: {$0.name == myGroup.name}) {
//                groups.append(myGroup)
//            }
//            
//            tableView.reloadData()
//        }
//
//    }
//    
//
//    
//
//    
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    
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
