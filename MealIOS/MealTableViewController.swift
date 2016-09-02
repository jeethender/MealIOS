//
//  MealTableViewController.swift
//  MealIOS
//
//  Created by maisapride8 on 11/06/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController
{

    //MARK: Properties.
    var meals = [Meal]()
    
    //MAR: Add SampleMeals
    
    func loadSampleMeals()
    {
        let photo1 = UIImage(named: "meal1")
        let meal1 = Meal(name: "Salad", photo: photo1, rating: 5)!
        
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Chicken", photo: photo2, rating: 4)!
        
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Noodles", photo: photo3, rating: 2)!
        
        
        // After creating Add these meals to Meals array
        
        meals  +=  [meal1, meal2, meal3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedMeals = loadMeals(){
            meals += savedMeals
        }else{
        //load sample data
        loadSampleMeals()
        }
       
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MealTableViewCell
        
      let  meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
        
    }
    
    @IBAction func unWindToMealList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal
        {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //edit existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }else{
                
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            //savemeals
            saveMeals()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailSegue"
        {
            let mealDetailVC = segue.destinationViewController as? MealViewController
            
            //get the cell which generate the segue
            if let selectedMealCell = sender as? MealTableViewCell
            {
                let indexPath =  tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailVC!.meal = selectedMeal
            }
            }else if segue.identifier == "AddItemSegue"{
            
    }
    }
    
    //MARK: TableViewCells editing Actions
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
     {
        if editingStyle == .Delete {
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
        } else if editingStyle == .Insert{
            
        }
    }
    //MARK: NSCoding.
    
    func saveMeals()
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("failed to save meals...")
        }
    }
    
    func loadMeals() -> [Meal]?
    {
        return  NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
    
    
    
    }
