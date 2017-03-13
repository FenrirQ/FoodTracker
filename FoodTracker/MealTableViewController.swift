//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Quang Ly Hoang on 3/13/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load the sample data
        loadSampleMeal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }

    //MARK: Private Methods
    private func loadSampleMeal() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Pancake", photo: photo1, rating: 5) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Pizza", photo: photo2, rating: 4) else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Phở bò", photo: photo3, rating: 5) else {
            fatalError("Unable to instantiate meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }
}
