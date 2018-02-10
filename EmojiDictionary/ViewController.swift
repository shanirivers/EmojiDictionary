//
//  ViewController.swift
//  EmojiDictionary
//
//  Created by Shani on 1/13/18.
//  Copyright © 2018 Shani Rivers. All rights reserved.
//

import UIKit

class ViewController: UITableViewController
{

    // Properties
    var data = [String]()
    var filteredData = [String]()
    var showSearchResults = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadListOfEmojiUnicodes()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    
    // TABLEVIEW METHODS
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return showSearchResults ? filteredData.count : data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // TODO: add unicode and description cell textlabel
        cell.textLabel?.text = ( showSearchResults ? convertToUnicode(charString: filteredData[indexPath.row]) : convertToUnicode(charString: data[indexPath.row]))
        
        return cell
    }
    
    // OTHER ACTIONS
    
    func convertToUnicode (charString: String) -> String?
    {
        if let charAsInt = Int(charString, radix: 16), let code = UnicodeScalar(charAsInt)
        {
            let unicode = String(code)
            
            var description = unicode.applyingTransform(.toUnicodeName, reverse: false)!.lowercased()
            
            let range = description.index(description.startIndex, offsetBy: 3)..<description.endIndex
            
            description = String(description[range])
            description.removeLast()
            
            return unicode + " " + description
            
        } else {
            print("Invalide code string - you failed")
            return nil
        }
    }
    
    
    func loadListOfEmojiUnicodes ()
    {
        let pathToFile = Bundle.main.path(forResource: "emoji", ofType: "txt")
        
        if let path = pathToFile
        {
            do
            {
                let str = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let roughDataArray = str.components(separatedBy: "\n")
                
                for line in roughDataArray
                {
                    var components = line.components(separatedBy: " ; ")
                    data.append(components[0])
                }
            } catch {
                data = []
            }
        }
        tableView.reloadData()
    }
}






































