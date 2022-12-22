//
//  NewsTableViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 16.07.2022.
//

import UIKit

//class NewsTableViewController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Новости"
//
//        // регистрация XIB
//        tableView.register(UINib(nibName: "XibNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsXib")
//
//    }
//    
//    
//    var newsList = [
//        PostNewsStruct(name: "Дмитрий", icon: UIImage(named: "iconNews-1"), date: "вчера в 17:19", textNews: "У сов трубчатые глаза. \nУ этих очаровательных птиц огромные глаза. И хотя чаще всего их сравнивают с круглыми блюдцами, на самом деле этот орган чувства у сов трубчатой формы вплоть до самого черепа. Подобная структура позволяет им гордиться дальнозоркостью, и совы могут разглядеть свою жертву на расстоянии многих метров в кромешной тьме. \nЕдинственный минус такого строения глаз состоит в том, что совы не могут ими вращать. Вместо этого птице приходится поворачивать всю голову, что дополняет их образ еще большей загадочностью.", textImage: UIImage(named: "news-1")),
//        PostNewsStruct(name: "Валентин", icon: UIImage(named: "iconNews-2"), date: "15.07.2022 в 09:32", textNews: "Совы способны поворачивать шею на 270 градусов. \nБлагодаря очень удачному строению шеи совы могут почти на 270 градусов поворачивать голову, что компенсирует недостаток сов видеть только прямо перед собой. Они почти полностью потеряли способность двигать глазами, поэтому им надо поворачивать голову. \n\nСовы способны видеть в трех измерениях.Глаза у совы светятся, отражая свет. Благодаря тому, что у сов в глазах есть слой особых клеток, которые улучшают чувствительность к источникам света, их глаза светятся, отражая свет. \nПо остроте слуха они превосходят всех птиц и большинство наземных позвоночных, включая млекопитающих. Совы способны слышать звуки частотой от 2 Гц (человек — от 16 Гц).", textImage: UIImage(named: "news-2")),
//        PostNewsStruct(name: "Светлана", icon: UIImage(named: "iconNews-3"), date: "01.06.2022 в 21:01", textNews: "Совы известны своей бесшумной атакой. \nПодкрасться к жертве незаметно им позволяет особая конструкция крыльев: \nво-первых, острый гребень, проходящий по переднему краю крыла, который при взмахе тормозит поток встречного воздуха, уменьшая шум; мягкий пух в передней части, и наконец, пористые перья на задней кромке крыла, уничтожающие завихрения, которые производят при смещении потока воздуха позади крыльев.Некоторые виды сов охотятся днем. \nВ основном, совы охотятся ночью, но есть виды сов, которые охотятся днем, например, снежная сова, малая сова и большая серая сова. \nСовы любят сидеть под дождем. Сидя под проливным дождем, они ухаживают за перьями.", textImage: UIImage(named: "news-3"))
//    ]
//    
// 
//
//    // MARK: - Table view data source
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newsList.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsXib", for: indexPath) as? XibNewsTableViewCell else {
//            preconditionFailure("Error")
//        }
//        
//        // аватар
//        cell.iconUserNews.image = newsList[indexPath.row].icon
//        // имя автора
//        cell.nameUserNews.text = newsList[indexPath.row].name
//        // дата новости
//        cell.dateUserNews.text = newsList[indexPath.row].date
//        cell.dateUserNews.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
//        cell.dateUserNews.textColor = UIColor.gray.withAlphaComponent(0.7)
//        //текст новости
//        cell.textNews.text = newsList[indexPath.row].textNews
//        cell.textNews.numberOfLines = 0
//        //картинка к новости
//        cell.imageNews.image = newsList[indexPath.row].textImage
//        cell.imageNews.contentMode = .scaleAspectFill
//
//        return cell
//    }
//    
//    
//    
////    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        print("нажата кнопка")
////        print(indexPath)
////        performSegue(withIdentifier: "", sender: nil)
////    }
//    
////    override func numberOfSections(in tableView: UITableView) -> Int {
////        // #warning Incomplete implementation, return the number of sections
////        return newsList.count
////    }
////
////
////
////
////
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        // #warning Incomplete implementation, return the number of rows
////
////
////        return 0
////    }
//
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
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
//
//}
